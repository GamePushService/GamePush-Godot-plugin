import os
import re


# PascalCase → snake_case
def to_snake_case(name: str) -> str:
    s = ""
    for i, ch in enumerate(name):
        if ch.isupper():
            if i > 0:
                s += "_"
            s += ch.lower()
        else:
            s += ch
    return s


# Основная функция обработки текста
def fix_gp_modules(text: str) -> str:
    # Ищем GP.<ModuleName>
    pattern = re.compile(r"GP\.([A-Z][A-Za-z0-9]*)")

    def repl(match):
        module_name = match.group(1)

        # --- ИСКЛЮЧЕНИЕ ---
        # Не трогаем классы начинающиеся с GP
        if module_name.startswith("GP"):
            return f"GP.{module_name}"

        snake = to_snake_case(module_name)
        return f"GP.{snake}"

    return pattern.sub(repl, text)


# Рекурсивно собираем все .gd файлы
def get_all_gd_files(root: str):
    gd_files = []
    for dirpath, _, filenames in os.walk(root):
        for f in filenames:
            if f.endswith(".gd"):
                gd_files.append(os.path.join(dirpath, f))
    return gd_files


def main():
    root = "."

    gd_files = get_all_gd_files(root)

    for file_path in gd_files:
        with open(file_path, "r", encoding="utf-8") as f:
            old_text = f.read()

        new_text = fix_gp_modules(old_text)

        if new_text != old_text:
            with open(file_path, "w", encoding="utf-8") as f:
                f.write(new_text)
            print(f"Updated: {file_path}")

    print("Done.")


if __name__ == "__main__":
    main()
