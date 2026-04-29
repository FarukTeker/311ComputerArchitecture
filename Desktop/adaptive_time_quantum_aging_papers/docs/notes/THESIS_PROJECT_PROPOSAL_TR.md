# Tez / Proje Onerisi

## Onerilen Baslik

`Yapay Zeka Destekli Aging-Aware Adaptive Time Quantum Secimi ile Guvenilir ve Verimli Scheduler Tasarimi`

Alternatif daha akademik baslik:

`Cross-Layer Aging-Aware Adaptive Scheduling: Time Quantum, Thermal State ve Reliability Feedback ile Hibrit Bir Yontem`

## Problem Tanimi

Klasik Round Robin ve benzeri scheduler yapilarinda `time quantum` genellikle sabit ya da yalnizca is yukune bakilarak ayarlanir. Bu durum performans metrigi acisindan bir miktar iyilesme saglasa da, donanim yaslanmasi, sicak nokta birikimi, thermal cycling ve cekirdek bazli dengesiz stres dagilimi gibi guvenilirlik problemlerini dogrudan dikkate almaz.

Modern multicore ve gomulu sistemlerde scheduler kararlarinin donanim omru uzerinde gercek etkisi vardir. Bu nedenle yalnizca `waiting time` veya `turnaround time` degil, ayni zamanda `aging rate`, `thermal stress` ve `projected lifetime` da scheduler tasariminda karar degiskeni haline gelmelidir.

Bu proje/tez, `time quantum` secimini sadece queue durumuna degil, donanim saglik gostergelerine de baglayan `aging-aware adaptive scheduler` tasarlamayi amaclar.

## Arastirma Sorusu

`Bir scheduler, ready-queue bilgisi ile birlikte thermal ve aging telemetry verilerini kullanarak time quantum degerini adaptif secerse, sabit veya klasik dinamik quantum yontemlerine gore benzer performans altinda daha dusuk aging hizi ya da ayni aging butcesi altinda daha iyi performans saglayabilir mi?`

## Hipotez

Ana hipotez:

`Queue-aware + aging-aware` hibrit bir scheduler, sabit RR ve yalnizca burst-statistics tabanli dinamik RR scheduler'lara gore daha dengeli bir performans-guvenilirlik trade-off'u saglar.

Alt hipotezler:

1. Thermal ve aging geri bildirimi kullanilarak secilen quantum, hot spot olusumunu azaltir.
2. Cekirdek bazli stres dengelemesi projected lifetime'i iyilestirir.
3. Physics-informed bir ML modeli, saf heuristic yontemlerden daha iyi genelleme saglar.
4. RL tabanli kontrol, yeterli simulator ve guvenlik kisitlariyla daha iyi uzun vadeli kontrol politikasi ogrenebilir.

## Amaclar

1. Adaptive time quantum literaturunu aging-aware reliability control ile birlestiren bir scheduler modeli gelistirmek.
2. Queue metrikleri ile thermal/aging metriklerini ayni karar mekanizmasina dahil etmek.
3. Performance, thermal stress ve aging cost arasindaki trade-off'u nicel olarak gostermek.
4. Heuristic, supervised ML ve gerekirse RL tabanli farkli kontrol stratejilerini karsilastirmak.

## Yenilik Katkisi

Bu calismanin olasi ozgun katkisi su olabilir:

1. `Adaptive time quantum` literaturu ile `aging-aware runtime control` literaturunu dogrudan birlestirmesi
2. Scheduler seviyesinde `performance + aging` ortak optimizasyonu yapmasi
3. `Physics-informed adaptive scheduler` gibi aciklanabilir bir melez model sunmasi
4. `same performance, less aging` veya `same aging budget, better performance` iddiasini deneysel olarak test etmesi

## Onerilen Yontem

Calisma 3 katmanli ilerleyebilir:

### Asama 1: Heuristic Hibrit Scheduler

Quantum secimi:

`Q = f(queue_state) - penalty(thermal_state, aging_state)`

Burada:
- `f(queue_state)` mean/median/quartile benzeri bir temel quantum uretir
- `penalty(...)` sicaklik, termal gradient, utilization history ve aging score'a gore quantum'u duzeltir

Bu asama minimum uygulanabilir bilimsel modeldir.

### Asama 2: Supervised Learning ile Quantum Prediction

Girdi:
- queue length
- average remaining burst
- burst variance
- context switch rate
- CPU utilization
- current temperature
- per-core stress score
- recent frequency/voltage history

Cikti:
- optimum quantum sinifi veya sayisal quantum degeri

Modeller:
- Random Forest
- XGBoost
- LightGBM

### Asama 3: RL veya Contextual Bandit Controller

State:
- scheduler queue state
- temperature state
- aging estimate
- core load distribution

Action:
- quantum secimi
- DVFS seviyesi secimi
- cekirdek secimi / migration karari

Reward:
- throughput odulu
- latency cezasi
- context switch cezasi
- thermal hotspot cezasi
- aging acceleration cezasi

## Beklenen Bilimsel Katki

Bu tez/proje su tur katkilar verebilir:

1. Adaptive quantum scheduler'larin aging etkisini sistematik incelemek
2. Aging-aware scheduler tasarimi icin kullanilabilir bir feature set onermek
3. Queue-temelli ve donanim-temelli telemetry'nin ortak kullaniminin faydasini gostermek
4. Guvenli AI tabanli scheduler tasarimi icin bir yol haritasi sunmak

## Baseline Yontemler

Karsilastirma icin en az su yontemler kullanilmali:

1. Fixed Round Robin
2. Mean-based dynamic quantum
3. Median/quartile-based dynamic quantum
4. Thermal-aware ama aging-aware olmayan scheduler
5. Aging-aware DVFS ama adaptive quantum icermeyen sistem
6. Onerilen heuristic hybrid scheduler
7. Onerilen ML tabanli scheduler
8. Mumkunse RL tabanli scheduler

## Degerlendirme Metrikleri

1. Average waiting time
2. Average turnaround time
3. Average response time
4. Throughput
5. Context switch count
6. Energy consumption
7. Peak temperature
8. Thermal cycling severity
9. Aging increment score
10. Projected lifetime
11. Fairness / starvation risk

## Muhtemel Sonuclar

Beklenen ana sonuc tipi:

1. Fixed RR'a gore daha iyi latency
2. Klasik dynamic RR'a gore daha dengeli context switch davranisi
3. Peak temperature ve thermal stress'te azalma
4. Core bazli aging dagiliminda dengeleme
5. Benzer throughput seviyesinde daha dusuk aging birikimi

## Riskler

1. Aging modeli fazla basit kalirsa sonuc gercekcilikten uzaklasabilir
2. ML modeli sentetik veri ustunde overfit olabilir
3. RL tarafi egitim maliyeti ve reward tasarimi nedeniyle gecikmeli verim verebilir
4. Scheduler overhead kazanimi azaltabilir

## Risk Azaltma Stratejisi

1. Once heuristic model ile basla
2. Basit ama acik aging score kullan
3. Sensitivity analysis yap
4. Safety constraints uygula
5. ML/RL'yi sadece baseline'lar oturduktan sonra devreye al

## Sonuc

Bu tez/proje, scheduler tasarimini yalnizca performans problemi olmaktan cikarip `cross-layer reliability control` problemine donusturuyor. En guclu yonu, literaturde ayri duran iki ana damari birlestirerek `aging-aware adaptive time quantum` fikrini merkezi bir arastirma sorusu haline getirmesi olur.

Bu haliyle hem bitirme projesi hem de yuksek lisans tezi icin yeterince teknik, deneysel ve ozgun bir cerceve sunar.
