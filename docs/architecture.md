## MPPT Solar Optimization – Architecture

- ESP32 reads solar panel voltage and current.
- Runs Perturb & Observe MPPT algorithm in Embedded C.
- Adjusts DC-DC converter duty cycle using PWM.
- Sends live data to Firebase using WiFi.
- Flutter app fetches this data from Firestore in real time.