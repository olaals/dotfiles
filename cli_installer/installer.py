import os
import platform
import yaml
import glob
from pathlib import Path
import subprocess
import questionary
from rich.console import Console

console = Console()

class Installer:
    def __init__(self, snippets_dir: str = "install-snippets"):
        self.snippets_dir = Path(snippets_dir).resolve()
        self.os_map_path = self.snippets_dir / "os_map.yaml"
        self.mappings = self._load_mappings()

    def _load_mappings(self) -> dict:
        if not self.os_map_path.exists():
            console.print(f"[yellow]Warning: os_map.yaml not found at {self.os_map_path}[/yellow]")
            return {}
        
        with open(self.os_map_path, 'r') as f:
            data = yaml.safe_load(f)
            return data.get("mappings", {})

    def _get_current_os_tags(self) -> set:
        system = platform.system().lower()
        tags = {"all"}
        
        if system == "linux":
            tags.add("linux")
            # Try to get more specific linux distro info
            try:
                with open("/etc/os-release") as f:
                    for line in f:
                        if line.startswith("ID="):
                            distro = line.split("=")[1].strip().strip('"')
                            tags.add(distro.lower())
                            break
            except FileNotFoundError:
                pass
        elif system == "darwin":
            tags.add("darwin")
        
        return tags

    def find_available_scripts(self) -> list:
        current_tags = self._get_current_os_tags()
        available_scripts = []
        
        # Keep track of added scripts to avoid duplicates
        added_paths = set()

        for glob_pattern, allowed_oses in self.mappings.items():
            if not any(tag in allowed_oses for tag in current_tags):
                continue
            
            # Combine base dir with glob pattern
            search_pattern = str(self.snippets_dir / glob_pattern)
            matched_files = glob.glob(search_pattern, recursive=True)
            
            for file_path in matched_files:
                path_obj = Path(file_path)
                if path_obj.is_file() and file_path not in added_paths:
                    # Filter out non-script files like yaml, txt, etc.
                    if path_obj.suffix in ['.sh', '.py', '']:
                        available_scripts.append(path_obj)
                        added_paths.add(file_path)
                        
        return sorted(list(available_scripts))

    def run_script(self, script_path: Path):
        console.print(f"\n[cyan]Running script: {script_path.name}[/cyan]")
        home_dir = str(Path.home())
        try:
            if script_path.suffix == '.py':
                subprocess.run(['python3', str(script_path)], check=True, cwd=home_dir)
            elif script_path.suffix == '.sh':
                subprocess.run(['bash', str(script_path)], check=True, cwd=home_dir)
            else:
                # If no extension or unknown, try to run it directly
                os.chmod(str(script_path), 0o755)
                subprocess.run([str(script_path)], check=True, cwd=home_dir)
                
            console.print(f"[green]Successfully executed {script_path.name}[/green]")
        except subprocess.CalledProcessError as e:
            console.print(f"[red]Error executing {script_path.name}: process exited with code {e.returncode}[/red]")
        except Exception as e:
            console.print(f"[red]Failed to execute {script_path.name}: {e}[/red]")

    def start_selection_ui(self):
        scripts = self.find_available_scripts()
        
        if not scripts:
            console.print("[yellow]No relevant scripts found for your OS. Check install-snippets/os_map.yaml mappings.[/yellow]")
            return

        choices = [
            questionary.Choice(
                title=f"{script.relative_to(self.snippets_dir)}",
                value=script
            ) for script in scripts
        ]

        selected_scripts = questionary.checkbox(
            "Which tools would you like to install?",
            choices=choices
        ).ask()

        if not selected_scripts:
            console.print("[yellow]No scripts selected. Exiting.[/yellow]")
            return
            
        console.print(f"\n[bold]Installing {len(selected_scripts)} tools...[/bold]")
        
        for script in selected_scripts:
            self.run_script(script)
            
        console.print("\n[bold green]Installation process finished![/bold green]")
