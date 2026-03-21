// extension.js
const vscode = require("vscode");

function activate(context) {
  const cmd = vscode.commands.registerCommand("copyErrorAtCursor", async () => {
    const editor = vscode.window.activeTextEditor;
    if (!editor) return;

    const pos = editor.selection.active;
    const diags = vscode.languages.getDiagnostics(editor.document.uri);

    const match = diags
      .filter(d => d.range.start.line <= pos.line && d.range.end.line >= pos.line)
      .sort((a, b) => {
        const distA = Math.min(Math.abs(a.range.start.character - pos.character), Math.abs(a.range.end.character - pos.character));
        const distB = Math.min(Math.abs(b.range.start.character - pos.character), Math.abs(b.range.end.character - pos.character));
        return distA - distB;
      })[0];
    if (!match) return;

    await vscode.env.clipboard.writeText(match.message);
    vscode.window.setStatusBarMessage("Copied error", 1500);
  });

  context.subscriptions.push(cmd);
}

exports.activate = activate;