from cli_installer.installer import Installer
from rich.console import Console

def main():
    console = Console()
    
    console.print("[bold blue]Starting Personal CLI Installer...[/bold blue]\n")
    # Using absolute path resolution from current working directory so the snippets_dir is found
    # whether ran as 'uv run main.py' or 'install-snippets'
    installer = Installer(snippets_dir="install-snippets")
    try:
        installer.start_selection_ui()
    except KeyboardInterrupt:
        console.print("\n[yellow]Installation cancelled![/yellow]")

if __name__ == "__main__":
    main()
