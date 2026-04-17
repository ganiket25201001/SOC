# Practical 1: Encrypt and Decrypt Data Using OpenSSL

## Aim
Encrypt and decrypt a text file using AES-256-CBC in OpenSSL.

## Lab Environment
- CyberOps Workstation VM
- Input file: /home/analyst/lab.support.files/letter_to_grandma.txt

## Steps

1. Open terminal and move to the lab files directory.

```bash
cd /home/analyst/lab.support.files
```

2. View the original message.

```bash
cat letter_to_grandma.txt
```

3. Encrypt the file (binary output).

```bash
openssl aes-256-cbc -in letter_to_grandma.txt -out message.enc
```

4. Check the encrypted output.

```bash
cat message.enc
```

5. Encrypt again with Base64 output for readable transport format.

```bash
openssl aes-256-cbc -a -in letter_to_grandma.txt -out message.enc
cat message.enc
```

6. Decrypt the file.

```bash
openssl aes-256-cbc -a -d -in message.enc -out decrypted_letter.txt
```

7. Verify decrypted content.

```bash
cat decrypted_letter.txt
```

## Expected Result
- A new file message.enc is created.
- decrypted_letter.txt matches the original plaintext.
