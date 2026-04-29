# Deney Plani ve Simulator Tasarimi

## Hedef

Amaç, `adaptive time quantum + aging-aware control` fikrini deneysel olarak test edebilecek bir altyapi kurmak ve farkli yontemleri ayni kosullarda karsilastirmaktir.

## Temel Deney Sorusu

`Queue bilgisi ile thermal/aging telemetry birlikte kullanildiginda, scheduler ayni performans seviyesinde daha dusuk aging birikimi saglayabilir mi?`

## Deney Mimarisinin Onerilen Yapisi

Simulator 4 ana modulu icermeli:

1. `Workload generator`
2. `Scheduler engine`
3. `Thermal/aging estimator`
4. `Metrics and logging layer`

## Modul 1: Workload Generator

Bu modul farkli is yukleri uretmeli.

### Uretilecek workload tipleri

1. CPU-bound kisa isler
2. CPU-bound uzun isler
3. Karisik burst dagilimli isler
4. I/O benzeri beklemeli isler
5. Bursty arrival pattern
6. Periodik task set
7. Hot-core olusturan dengesiz task set

### Dagilimler

Burst time icin:
- uniform
- normal
- exponential
- pareto / heavy-tail
- bimodal distribution

Arrival pattern icin:
- Poisson
- periodic
- bursty clustered arrivals

Bu cesitlilik gerekli cunku adaptive quantum yontemleri dagilim degisince farkli davranir.

## Modul 2: Scheduler Engine

### Baseline scheduler'lar

1. Fixed RR
2. Mean-based dynamic RR
3. Median-based dynamic RR
4. Quartile/percentile-based RR
5. Thermal-aware scheduler
6. Aging-aware scheduler without AI

### Onerilen scheduler'lar

1. `Heuristic hybrid scheduler`
2. `Supervised ML scheduler`
3. `Contextual bandit scheduler`
4. `RL scheduler` (opsiyonel ileri asama)

### Scheduler aksiyonlari

1. Quantum sec
2. Task'i belirli cekirdege ata
3. Gerekirse migration yap
4. Opsiyonel olarak DVFS state sec

## Modul 3: Thermal/Aging Estimator

Bu kisim fiziksel tam dogrulukta olmak zorunda degil, ama acik ve tutarli olmali.

### Basit termal model

Her core icin:

`T(t+1) = a * T(t) + b * utilization + c * switching_activity + d * ambient`

Burada ama c, yeni quantum seciminin ve process degisim sikliginin termal etkiye nasil yansidigini yakalamak icin kullanilabilir.

### Basit aging score modeli

Her pencere icin aging increment:

`A_delta = k1 * exp(alpha * T) + k2 * utilization^p + k3 * switching_rate`

Bu form fiziksel detaylari tamamen temsil etmez ama asagidaki mantigi korur:

1. Sicaklik arttikca aging hizlanir
2. Uzun sure yuksek utilization stres biriktirir
3. Yuksek switching degerleri HCI benzeri etkiler icin proxy olabilir

### Gelismis aging score secenegi

Istersen sonra bu skoru ayirabilirsin:

1. `BTI-like score`
2. `HCI-like score`
3. `Thermal cycling score`
4. `EM proxy score`

Bu durumda toplam maliyet:

`A_total = w1*BTI + w2*HCI + w3*TC + w4*EM`

## Modul 4: Logging ve Metrics

Her simülasyon kosusunda su log'lar tutulmali:

1. Zaman serisi quantum degeri
2. Ready queue boyutu
3. Her core utilization
4. Her core temperature
5. Her core aging score
6. Context switch olaylari
7. Task completion zamanlari
8. Migration sayisi
9. DVFS degisimleri varsa onlar

## Feature Set Onerisi

ML veya RL icin kullanilabilecek feature'lar:

1. queue length
2. average remaining burst time
3. median remaining burst time
4. burst variance
5. max burst / min burst
6. process age ortalamasi
7. context switch rate
8. current utilization per core
9. moving average utilization
10. current temperature per core
11. temperature gradient
12. cumulative stress score per core
13. last selected quantum
14. recent DVFS state
15. recent migration count

## Aksiyon Uzayi

Basit tutmak icin ayrik action space iyi olur.

### Quantum secenekleri

1. `Q in {4, 8, 16, 24, 32, 48, 64}`
2. veya normalize edilmis `small / medium / large`

### Diger aksiyonlar

1. cekirdek secimi
2. migration ac/kapat
3. opsiyonel DVFS level secimi

## Reward Tasarimi

RL veya contextual bandit icin onerilen reward:

`R = w_perf * throughput - w_lat * response_time - w_cs * context_switches - w_temp * hotspot_penalty - w_age * aging_increment`

Alternatif constrained tasarim:

`Performansi maksimize et, ama peak temperature < threshold ve aging_score < budget`

Bu ikinci tasarim tezde daha ciddi gorunur.

## Deney Fazlari

### Faz 1: Baseline Kurulumu

1. Fixed RR'i dogrula
2. Mean-based ve median-based dynamic RR'i ekle
3. Ayni workload setinde bunlari karsilastir

Amaç:
- simulatorun dogru calistigini gostermek
- adaptive quantum literaturu ile uyumlu ilk trendleri gormek

### Faz 2: Thermal ve Aging Katmani

1. Her core icin termal model ekle
2. Aging score hesapla
3. Fixed RR ve dynamic RR'in aging etkisini olc

Amaç:
- scheduler kararlarinin yalnizca latency degil aging uzerinde de etkili oldugunu gostermek

### Faz 3: Heuristic Hybrid Scheduler

Ornek karar mantigi:

1. queue yogunlugu yuksekse quantum artir
2. peak sicaklik yuksekse quantum artisini sinirla
3. ayni core'un aging score'u hizli buyuyorsa task rotation uygula
4. thermal gradient buyukse migration tetikle

Amaç:
- cok karmasik AI eklemeden ilk guclu sonucu almak

### Faz 4: Supervised Learning

#### Veri uretimi

Her workload icin farkli quantum degerlerini brute-force tara.

Her kosu icin su sonucu kaydet:

1. performance score
2. aging score
3. combined objective score

Sonra en iyi quantum'u label olarak ata.

#### Modeller

1. Random Forest
2. XGBoost
3. LightGBM

#### Degerlendirme

1. quantum prediction accuracy
2. objective gap to optimum
3. unseen workload genellemesi

### Faz 5: RL veya Contextual Bandit

Baslangic icin `contextual bandit` daha kolay olabilir.

Sonra RL:

1. DQN eger ayrik aksiyon kullanirsan
2. PPO eger policy daha stabil olsun istersen

#### RL egitim stratejisi

1. once sade state ile basla
2. sonra thermal feature ekle
3. en son aging feature ekle
4. reward weight sensitivity analizi yap

## Karsilastirma Senaryolari

Deneyleri en az su senaryolarda calistir:

1. dusuk yuk, serin sistem
2. yuksek yuk, serin sistem
3. yuksek yuk, sicak ortam
4. bursty gelen workload
5. long-tail burst distribution
6. tek hot-core olusturan dengesiz atama
7. multicore dengeli dagilim

## Raporlanacak Ana Grafikler

1. quantum vs waiting time
2. quantum vs context switches
3. temperature timeline
4. aging score timeline
5. projected lifetime comparison bar chart
6. throughput vs aging Pareto curve
7. fairness / tail latency karsilastirmasi

## Ablation Study

Bu kisim cok onemli.

Asagidaki varyantlari ayri ayri dene:

1. queue-only
2. queue + thermal
3. queue + aging
4. queue + thermal + aging
5. queue + thermal + aging + migration
6. queue + thermal + aging + DVFS

Bu, hangi bilginin gercek katkıyı verdigini gosterir.

## Sensitivity Analysis

1. sensor gurultusu eklendiginde ne oluyor
2. aging model katsayilari degisince ne oluyor
3. workload dagilimi kaydiginda model nasil davraniyor
4. reward weight degisince RL policy nasil kayiyor
5. action space buyuyunce stabilite bozuluyor mu

## Guvenlik ve Pratik Kisıtlar

Gercek sisteme gecmeyi dusunursen su guvenlik filtreleri olmali:

1. min quantum ve max quantum limitleri
2. peak temperature threshold
3. fairness bound
4. starvation prevention
5. max migration rate
6. max DVFS switching frequency

## En Mantikli Baslangic Konfigurasyonu

Benim onerim su sirayla gitmek:

1. Python tabanli basit discrete-event scheduler simulator
2. 4 core model
3. Fixed RR + mean RR + median RR baseline
4. Basit thermal model
5. Basit aging score
6. Heuristic hybrid policy
7. Random Forest tabanli prediction modeli
8. Son asamada contextual bandit veya DQN

Bu akış, hem hizli sonuc verir hem de tez/proje takvimine uygundur.

## Beklenen Deneysel Sonuclar

Makûl beklenti su olur:

1. `Heuristic hybrid` baseline'lari gecmeye baslar
2. `Supervised model` belirli workload ailelerinde daha iyi quantum tahmini yapar
3. `RL` en iyi teorik performansi verebilir ama egitim kararliligi daha zor olur
4. En savunulabilir sonuc, latency kaybi cok az iken aging score'un anlamli bicimde azalmasidir

## Basari Kriteri

Proje basarili sayilabilir eger sunlardan biri gosterilirse:

1. Ayni throughput altinda aging score anlamli azalir
2. Ayni aging limiti altinda waiting/turnaround iyilesir
3. Peak temperature ve hot-core stress dagilimi belirgin iyilesir
4. Onerilen scheduler en az birden fazla workload sinifinda tutarli ustunluk gosterir

## Kapanis

Bu deney duzeni seni dogrudan uygulanabilir bir arastirma hattina sokar. En dogru strateji, once aciklanabilir ve kucuk bir heuristic hybrid scheduler ile baslamak, sonra veriyi toplayip ML/RL katmanina gecmektir. Boylece hem bilimsel risk azalir hem de her asama tek basina raporlanabilir sonuc uretir.
