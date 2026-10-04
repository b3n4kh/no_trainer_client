#!/usr/bin/env python3
"""Usage: ./read-nmap-xml.py d2-http-repeat.xml [more.xml ...]."""
import argparse
import xml.etree.ElementTree as ET

parser = argparse.ArgumentParser(description="Print NSE script IDs and output from Nmap XML.")
parser.add_argument("files", nargs="+")
args = parser.parse_args()
for filename in args.files:
    root = ET.parse(filename).getroot()
    print(f"--- {filename} ---")
    for script in root.iter("script"):
        print(script.get("id"), script.get("output"))
