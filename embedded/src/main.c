#include "mppt.h"
#include <stdio.h>
#include "driver/adc.h"
#include "driver/pwm.h"
#include "esp_wifi.h"
#include "esp_log.h"
#include "nvs_flash.h"

float previous_power = 0;
float previous_voltage = 0;
float duty_cycle = 0.5;

void app_main() {
    adc1_config_width(ADC_WIDTH_BIT_12);
    adc1_config_channel_atten(ADC1_CHANNEL_0, ADC_ATTEN_DB_11);
    adc1_config_channel_atten(ADC1_CHANNEL_3, ADC_ATTEN_DB_11);

    pwm_setup();

    while (1) {
        float voltage = read_voltage();
        float current = read_current();
        float power = voltage * current;

        if (power > previous_power) {
            if (voltage > previous_voltage) {
                duty_cycle += 0.01;
            } else {
                duty_cycle -= 0.01;
            }
        } else {
            if (voltage > previous_voltage) {
                duty_cycle -= 0.01;
            } else {
                duty_cycle += 0.01;
            }
        }

        duty_cycle = clamp(duty_cycle, 0.0, 1.0);
        set_pwm_duty(duty_cycle);

        previous_voltage = voltage;
        previous_power = power;

        send_data_to_firebase(voltage, current, power, duty_cycle);
        vTaskDelay(1000 / portTICK_PERIOD_MS);
    }
}