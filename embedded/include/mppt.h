float read_voltage();
float read_current();
void pwm_setup();
void set_pwm_duty(float duty);
float clamp(float val, float min, float max);
void send_data_to_firebase(float v, float i, float p, float d);