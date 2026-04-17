# Practical 1: Encrypt and Decrypt Data Using OpenSSL

## Aim
Encrypt and decrypt a text file using AES-256-CBC with OpenSSL.

## Lab Environment
- CyberOps Workstation VM
- Input file: /home/analyst/lab.support.files/letter_to_grandma.txt

## Steps

1. Open terminal and move to the lab files directory.

```bash
cd /home/analyst/lab.support.files
```

2. Confirm input file is present.

```bash
ls -l letter_to_grandma.txt
```

3. View plaintext content.

```bash
cat letter_to_grandma.txt
```

4. Encrypt the file (binary ciphertext output).

```bash
openssl aes-256-cbc -in letter_to_grandma.txt -out message.enc
```

5. Confirm encrypted file is created.

```bash
ls -l message.enc
```

6. Encrypt again with Base64 output so ciphertext is human-readable text.

```bash
openssl aes-256-cbc -a -in letter_to_grandma.txt -out message.enc
```

7. View Base64 encrypted output.

```bash
cat message.enc
```

8. Decrypt the Base64 ciphertext back to plaintext.

```bash
openssl aes-256-cbc -a -d -in message.enc -out decrypted_letter.txt
```

9. View decrypted content.

```bash
cat decrypted_letter.txt
```

10. Verify decrypted content matches original.

```bash
diff -u letter_to_grandma.txt decrypted_letter.txt
```

## Expected Result
- message.enc is generated successfully.
- decrypted_letter.txt contains the same content as letter_to_grandma.txt.

## Notes
- Use the same password for both encryption and decryption.
- If OpenSSL prints a key-derivation warning in your environment, add the `-pbkdf2` option to both encrypt and decrypt commands.
