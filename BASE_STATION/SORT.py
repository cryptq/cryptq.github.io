import os, re

# Поиск файлов, где упоминается SamplingRate
# Можно найти любые параметры и управляющие команды в неограниченном количестве файлов.

pattern = re.compile(r'SamplingRate', re.IGNORECASE)
for root, _, files in os.walk(r'C:\Users\User\Desktop\SOFTWARE'):
    for f in files:
        if f.endswith('.c') or f.endswith('.h'):
            path = os.path.join(root, f)
            with open(path, encoding='utf-8', errors='ignore') as fh:
                if any(pattern.search(line) for line in fh):
                    print(f)
