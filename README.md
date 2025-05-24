# Reliable Auditable Key Generator 

## Motivation
Paper based backup of cryptographic keys can add an additional layer of security in case of failure.
Since trustworthyness for security based software is difficult to achieve,
this repository utilizes independent, robust and proven utilities and unifies the solution in
simple auditable scripts.

## Preparation
* Install dependencies via `./misc/install-dependencies.sh`
* Optionally create example keys via `./misc/generate-key.sh`

## Usage
* Create PDF from key via `./create-key-print-file.sh private.key`
* Create key from PDF via `./read-key-print-file.sh out/physical-key-file.pdf`

## Screenshot
![Screenshot](misc/screenshot.png?raw=true "Screenshot")

## Utilities
| Library       | Tested Version                       | Justification                                                        |
| ------------- | ------------------------------------ | -------------------------------------------------------------------- |
| openssl       | 3.0.2-0ubuntu1.19                    | Trusted cryptographic library used for key generation                |
| qrencode      | 4.1.1-1                              | Used for generating QR code images                                   |
| imagemagick   | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.5  | The convert tool is used to convert images to a PDF and vice versa   |
| zbar-tools    | 4.1.1-1                              | The zbarimg tool is used to read images of scanned QR codes          |
