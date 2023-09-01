#!/bin/bash

output_file="revoked.pem"
temp_crl="temp.crl"
input_file="crl_urls.txt"

# Check if the input file exists
if [ ! -e "$input_file" ]; then
	echo "Couldn't find crl urls file ($input_file)"
	exit 1
fi

# Loop through each line in the input file
while IFS= read -r line; do
	# If a CRL URL was found
	if [ ! -z "$line" ]; then
		# Download the CRL to a temporary file
		echo "Downloading $line"
		curl -s "$line" -o "$temp_crl"

		# If the download was successful, append to the output file
		if [ $? -eq 0 ]; then
			if [ "$(file "$temp_crl" -b)" = "data" ]; then
				# Convert to PEM
				openssl crl -inform DER -in "$temp_crl" -outform PEM -out "$temp_crl"
				cat "$temp_crl" >> "$output_file"
			else
				echo "Error: CRL file is not in 'data' format from $line. Ignoring..."
			fi
		else
			echo "Error: Failed to download CRL for $pem from $line"
		fi
	else
		echo "Error: No CRL URL found in $pem"
		exit 1
	fi
done < "$input_file"

# Clean up the temporary file
rm -f "$temp_crl"
