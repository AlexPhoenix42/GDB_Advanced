
```markdown
# 🐞 GDB Conditional Breakpoint Template

This `.gdbinit` script sets up a **conditional breakpoint system** in GDB using convenience variables. It allows you to trigger one breakpoint **only after another has been hit**, which is especially useful for debugging complex flows or tracking state-dependent behavior.

## 🚀 Features

- Automatically loads your binary and arguments
- Enables TUI mode for a better debugging interface
- Uses a GDB variable (`$bp2hit`) to track breakpoint state
- Avoids GDB crashes by carefully sequencing commands
- Includes optional logging to your terminal

## 🧠 How It Works

1. **Breakpoint A** is set at a specific location (e.g. `event_handler.c:112`) and sets a flag `$bp2hit = 1` when hit.
2. **Breakpoint B** is conditional: it only triggers if `$bp2hit == 1`.
3. When Breakpoint B is hit, it resets the flag to `$bp2hit = 0`, ensuring it only triggers once per cycle.

This avoids triggering Breakpoint B until Breakpoint A has occurred, allowing for precise control over your debugging flow.

## 🛠️ Setup Instructions

1. Replace the following placeholders in `.gdbinit`:
   - `./your_program` → your compiled binary
   - `your_args` → any command-line arguments
   - `source_file.c:line_number` → location of Breakpoint A
   - `function_name` → location of Breakpoint B
   - `/dev/pts/X` → your terminal (run `tty` to find it)

2. Launch GDB:
   ```bash
   gdb
   ```

3. The script will:
   - Load your binary
   - Set breakpoints
   - Initialize the flag
   - Enable logging (optional)

## ⚠️ Notes

- **Do not use `continue` inside breakpoint command blocks.** This can cause GDB to crash with `No frame is currently selected`.
- Use `start` instead of `run` to ensure GDB pauses at `main` and has a valid frame before setting variables.
- Logging only works if you set the correct terminal path.

## 📎 Example `.gdbinit` Snippet

```gdb
file ./your_program
set breakpoint pending on
set args your_args
tui enable

start
set $bp2hit = 0

break source_file.c:line_number
commands
  set $bp2hit = 1
  set logging file /dev/pts/X
  set logging enable on
end

break function_name if $bp2hit == 1
commands
  set $bp2hit = 0
end
```

## 📬 Feedback & Contributions

Feel free to fork, improve, or submit issues! If you’ve got a clever extension or want to automate terminal detection, I’d love to see it.

---

## 📄 License
This project is licensed under the MIT License. See the LICENSE file for details.

---

## Powered by github.com/AlexPhoenix42 🌈🚀
https://github.com/AlexPhoenix42
