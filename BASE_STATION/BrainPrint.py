# Создание синтетических "мозговые отпечатки" в виде файлов:
# - матрицы функциональной связности (connectivity) для каждого субъекта (CSV)
# - сырые EEG времена́ серии (NumPy .npy и CSV) для каждого субъекта
# - извлечённый вектор признаков (features.csv)
# - метаданные (metadata.json)
# - README (README.txt)
#
# Затем отображаю таблицу с признаками и делаю два графика:
# 1) heatmap матрицы связности субъекта 1
# 2) фрагмент EEG (канал 0, первые 2 секунды)
#
# Примечание: данные полностью синтетические и сгенерированы случайно с наложением
# структур, чтобы демонстрировать "уникальную подпись" каждого субъекта.

import os
import json
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import networkx as nx
from scipy.signal import welch

# Папка для вывода
out_dir = "/mnt/data/brainprints_example"
os.makedirs(out_dir, exist_ok=True)

rng = np.random.default_rng(42)

# Параметры
n_subjects = 5
n_regions = 100            # регионы для "fMRI"-подобной матрицы связности
eeg_channels = 32
eeg_seconds = 20
sr = 250                   # sampling rate (Hz)
eeg_samples = eeg_seconds * sr

subjects = []
features_list = []
metadata = {}

# Функции для генерации структурированной матрицы связности
def make_structured_conn(n, rank=6, base_strength=0.6, noise_level=0.05, subject_bias=0.02, seed=None):
    rs = np.random.RandomState(seed)
    # Низкоранговая структура (общие сети)
    U = rs.normal(size=(n, rank))
    vals = np.linspace(1.0, 0.2, rank)
    L = U @ np.diag(vals) @ U.T
    # Делать симметричной и масштабировать
    L = (L + L.T) / 2.0
    # Добавим небольшую субъективную (уникальную) модификацию
    bias = rs.normal(scale=subject_bias, size=(n,n))
    bias = (bias + bias.T) / 2.0
    mat = base_strength * L + bias
    # Шум и диагональ
    mat = mat + np.eye(n) * 0.1
    mat = mat + rs.normal(scale=noise_level, size=(n,n))
    mat = (mat + mat.T) / 2.0
    # Преобразуем в корреляцию (корреляционная матрица должна иметь единицы на диагонали)
    d = np.sqrt(np.diag(mat))
    corr = mat / np.outer(d, d)
    corr[np.isnan(corr)] = 0.0
    # Ограничим чтобы быть в пределах [-1,1]
    corr = np.clip(corr, -0.99, 0.99)
    return corr

# Функция генерации синтетического EEG с субъективными особенностями
def make_synthetic_eeg(channels, samples, sr, subject_id, rng):
    t = np.arange(samples) / sr
    eeg = np.zeros((channels, samples))
    # Общие частоты
    freqs = [3, 6, 10, 20, 40]  # delta/theta/alpha/beta/gamma центры
    for ch in range(channels):
        # линейная смесь синусоид с рандомными фазами и небольшими вариациями частот
        signal = np.zeros(samples)
        for f in freqs:
            phase = rng.uniform(0, 2*np.pi)
            amp = rng.uniform(0.1, 1.0)
            # subject-specific modulation: смещение частоты и амплитуды
            freq_shift = (subject_id - 1) * 0.02 * f
            signal += amp * np.sin(2*np.pi*(f + freq_shift)*t + phase)
        # добавим артефакты / 1/f noise
        noise = rng.normal(scale=0.5, size=samples) * 0.3
        eeg[ch] = signal + noise
        # channel-specific slight gain
        eeg[ch] *= (1.0 + 0.01 * (ch - channels/2))
    # Нормировка
    eeg = eeg / np.std(eeg)
    return eeg

# Извлечение признаков из матрицы связности и EEG
def extract_conn_features(conn, top_k_eig=10, threshold=0.2):
    # собственные числа
    eigvals = np.linalg.eigvalsh(conn)
    eigvals_sorted = np.sort(eigvals)[::-1]
    top_eig = eigvals_sorted[:top_k_eig]
    # бинарная сеть по порогу
    adj = (conn > threshold).astype(float)
    G = nx.from_numpy_array(adj)
    degrees = np.array([d for _, d in G.degree()])
    features = {
        "eig_1": float(top_eig[0]),
        "eig_2": float(top_eig[1]) if len(top_eig)>1 else 0.0,
        "mean_degree": float(degrees.mean()),
        "std_degree": float(degrees.std()),
        "n_edges": int(G.number_of_edges())
    }
    return features

def extract_eeg_bandpowers(eeg, sr):
    # eeg: channels x samples
    bands = {"delta": (1,4), "theta": (4,8), "alpha": (8,12), "beta": (12,30), "gamma": (30,80)}
    band_powers = {}
    # Усредним по каналам: compute relative band power (Welch)
    for band, (fmin, fmax) in bands.items():
        psd_sum = 0.0
        for ch in range(eeg.shape[0]):
            f, Pxx = welch(eeg[ch], fs=sr, nperseg=512)
            mask = (f>=fmin) & (f<fmax)
            band_pwr = np.trapz(Pxx[mask], f[mask]) if mask.any() else 0.0
            psd_sum += band_pwr
        band_powers[f"band_{band}_mean"] = float(psd_sum / eeg.shape[0])
    return band_powers

# Генерация данных
for sid in range(1, n_subjects+1):
    subj_id = f"S{subj:02d}".replace("subj","")
    subj_label = f"subj_{sid}"
    subjects.append(subj_label)
    # connectivity
    conn = make_structured_conn(n_regions, rank=8, base_strength=0.75, noise_level=0.03,
                                 subject_bias=0.02, seed=100+sid)
    conn_path = os.path.join(out_dir, f"{subj_label}_connectivity.csv")
    pd.DataFrame(conn).to_csv(conn_path, index=False)
    # eeg
    eeg = make_synthetic_eeg(eeg_channels, eeg_samples, sr, sid, np.random.default_rng(1000+sid))
    eeg_npy_path = os.path.join(out_dir, f"{subj_label}_eeg.npy")
    np.save(eeg_npy_path, eeg)
    eeg_csv_path = os.path.join(out_dir, f"{subj_label}_eeg_sample.csv")
    # Сохраним небольшой CSV с первыми 1000 семплами для удобного просмотра
    pd.DataFrame(eeg[:, :1000]).to_csv(eeg_csv_path, index=False)
    # features
    conn_feat = extract_conn_features(conn, top_k_eig=10, threshold=0.22)
    eeg_feat = extract_eeg_bandpowers(eeg, sr)
    combined = {"subject": subj_label, "n_regions": n_regions, "eeg_channels": eeg_channels}
    combined.update(conn_feat)
    combined.update(eeg_feat)
    features_list.append(combined)
    # metadata
    metadata[subj_label] = {
        "subject_id": subj_label,
        "age": int(14 + sid),          # синтетический возраст подростка
        "sex": "M" if sid%2==1 else "F",
        "scanner": "Simulated-fMRI-3T",
        "eeg_device": "Simulated-EEG-32ch",
        "connectivity_file": os.path.basename(conn_path),
        "eeg_file_npy": os.path.basename(eeg_npy_path),
        "eeg_file_csv_preview": os.path.basename(eeg_csv_path),
        "notes": "Synthetic example data for demonstration only"
    }

# Сохраняем features
features_df = pd.DataFrame(features_list)
features_csv_path = os.path.join(out_dir, "features.csv")
features_df.to_csv(features_csv_path, index=False)

# Сохраняем metadata
metadata_path = os.path.join(out_dir, "metadata.json")
with open(metadata_path, "w", encoding="utf-8") as f:
    json.dump(metadata, f, ensure_ascii=False, indent=2)

# README
readme_text = f"""
Synthetic brainprints example dataset
Files in directory: {out_dir}

For each subject subj_1..subj_{n_subjects}:
 - subj_X_connectivity.csv   : N_regions x N_regions symmetric correlation matrix (CSV)
 - subj_X_eeg.npy            : numpy array (channels x samples) with raw EEG (NumPy .npy)
 - subj_X_eeg_sample.csv     : preview CSV (channels x first 1000 samples)

Also:
 - features.csv              : tabular feature vectors extracted for each subject
 - metadata.json             : simple metadata describing files
 - README.txt                : this file

Notes:
 - All data are synthetic and for demonstration only.
 - Connectivity matrices are generated with low-rank structure + subject-specific perturbations
   so that each subject has a "unique signature" while remaining obviously artificial.
 - EEG signals are mixtures of sinusoids with subject-specific frequency shifts + noise.
"""
with open(os.path.join(out_dir, "README.txt"), "w", encoding="utf-8") as f:
    f.write(readme_text)

# Отображение таблицы признаков (используйте display_dataframe_to_user)
import caas_jupyter_tools as cjt
cjt.display_dataframe_to_user("Extracted features (synthetic)", features_df)

# Построение heatmap для субъекта 1
fig1, ax1 = plt.subplots(figsize=(6,5))
subj0_conn = pd.read_csv(os.path.join(out_dir, "subj_1_connectivity.csv")).values
im = ax1.matshow(subj0_conn)
ax1.set_title("Connectivity matrix (subj_1) - synthetic")
plt.colorbar(im, ax=ax1, fraction=0.046, pad=0.04)
plt.tight_layout()
plt.savefig(os.path.join(out_dir, "subj_1_connectivity_heatmap.png"))

# Построение фрагмента EEG (субъект 1, канал 0, первые 2 секунды)
fig2, ax2 = plt.subplots(figsize=(8,3))
eeg1 = np.load(os.path.join(out_dir, "subj_1_eeg.npy"))
t = np.arange(int(2*sr)) / sr
ax2.plot(t, eeg1[0, :int(2*sr)])
ax2.set_xlabel("Time (s)")
ax2.set_ylabel("Amplitude (a.u.)")
ax2.set_title("EEG channel 0 (subj_1), first 2 seconds - synthetic")
plt.tight_layout()
plt.savefig(os.path.join(out_dir, "subj_1_eeg_ch0_2s.png"))

# Сохраняем небольшую ZIP архивацию всех файлов
import zipfile
zip_path = os.path.join(out_dir, "brainprints_example_dataset.zip")
with zipfile.ZipFile(zip_path, "w", compression=zipfile.ZIP_DEFLATED) as zf:
    for fname in os.listdir(out_dir):
        if fname.endswith(".zip"):
            continue
        zf.write(os.path.join(out_dir, fname), arcname=fname)

# Печатаем путь к файлам для пользователя
print("Created files in:", out_dir)
print("Main archive:", zip_path)
print("Features table:", features_csv_path)
print("Metadata:", metadata_path)
print("README:", os.path.join(out_dir, "README.txt"))
print("Example images:", 
      os.path.join(out_dir, "subj_1_connectivity_heatmap.png"),
      os.path.join(out_dir, "subj_1_eeg_ch0_2s.png"))


##################################################################