import serial

PORT = "/dev/ttyUSB1"

BAUDRATE = 115200
TIMEOUT = 1 

tx_byte = b'C'  
def byte_to_bits(byte):
    return format(byte, '08b')

try:
    ser = serial.Serial(
        port=PORT,
        baudrate=BAUDRATE,
        bytesize=serial.EIGHTBITS,
        parity=serial.PARITY_NONE,
        stopbits=serial.STOPBITS_ONE,
        timeout=TIMEOUT
    )

    print(f"Открыт порт {PORT}")

    ser.write(tx_byte)
    ser.flush()

    print("Отправлено:")
    print(f" HEX: {tx_byte.hex().upper()}")
    print(f" BIN: {byte_to_bits(tx_byte[0])}")

    rx = ser.read(1)

    if rx:
        print("\nПолучено:")
        print(f" HEX: {rx.hex().upper()}")
        print(f" BIN: {byte_to_bits(rx[0])}")
    else:
        print("\nтаймаут")

    ser.close()

except serial.SerialException as e:
    print(f"Ошибка UART: {e}")