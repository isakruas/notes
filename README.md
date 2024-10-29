
# Useful Commands for Personal Notes

## Adding a Note
To add a new note, you have two options:
- Run the command and interactively provide the title:
  ```bash
  make add
  ```
- Provide the title directly in the command:
  ```bash
  make add TITLE="Your Note Title"
  ```

## Listing Notes
To list all your notes grouped by prefix, use:
- Simply list all notes:
  ```bash
  make list
  ```
- List notes using a keyword search:
  ```bash
  make list SEARCH="keyword"
  ```

## Editing a Note
To edit an existing note, use:
```bash
make edit
```
You will be prompted to enter the note's name, and it will open in your default text editor.

## Cleaning Up
To remove all notes, use:
```bash
make clean
```
You will be asked for confirmation before proceeding with the deletion.

## Formatting Notes
To ensure all lines in your notes are no longer than 80 characters, use the `format` command. This helps improve the readability of your notes by breaking down long lines:
```bash
make format
```
This command reformats each note file by wrapping lines at word boundaries, ensuring a maximum line length of 80 characters.

## Display Help Information
For more information on available commands and usage, use:
```bash
make help
```