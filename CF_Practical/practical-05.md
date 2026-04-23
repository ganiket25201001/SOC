# Practical 5: Perform network forensics using tools like Wireshark, NetworkMiner, tcpdump, etc. Use minimum three tools.

## Content

Aim: To capture and analyze traffic for suspicious patterns or unencrypted credentials.
Prerequisites: Wireshark, NetworkMiner (Windows), tcpdump (Kali).
Implementation 1: Windows Environment
Tool A: Wireshark (The Microscope)
Capture: Open Wireshark. Select your active Network Interface (e.g., Wi-Fi or Ethernet). Click the blue shark fin to start capturing.
Filter: Use the filter bar to isolate specific traffic.
http: Shows only web traffic.
ip.addr == [Suspect_IP]: Shows all traffic to/from a specific machine.
dns: Shows all website lookups (good for finding C2 - Command and Control servers).
Follow Stream: Right-click a TCP packet -> Follow -> TCP Stream. This reconstructs the "conversation" in a readable format.
Export Objects: Go to File -> Export Objects -> HTTP. You can literally "re-download" files the suspect downloaded during the capture.
Tool B: NetworkMiner (The Automated Investigator)
Load: Open NetworkMiner. Go to File -> Open and select your saved .pcap file.
Artifact Discovery: Unlike Wireshark, NetworkMiner is "artifact-centric."
Files Tab: Automatically lists every file transferred over the network (images, EXEs, docs).
Images Tab: Shows a gallery of images viewed by the user.
Credentials Tab: Automatically extracts usernames and passwords from unencrypted logins.
Observation: Use this to quickly see what was taken, while Wireshark tells you how.
Listen carefully. In the world of elite incident response, disk forensics tells you what happened, but Network Forensics tells you what is happening or how the intruder got in. It is the only way to catch an adversary in motion.

When I was at the "Top 5" firms, we called network traffic the "ultimate truth." A suspect can delete logs and wipe drives, but they cannot hide the packets they sent across the wire—provided you were capturing them. Under Section 63 of the Bharatiya Sakshya Adhiniyam (BSA) 2023, a network packet capture (PCAP) is a potent piece of electronic evidence, but only if you can prove its source and that it hasn't been filtered or tampered with during collection.

In this practical, we are moving from the "dead" forensics of hard drives to the "live" forensics of the wire.

Practical 5: Network Forensics and Packet Analysis
Aim: To capture, analyze, and reconstruct network traffic to identify suspicious patterns, unauthorized data exfiltration, or cleartext credential leakage.

Prerequisites:

Environment: A local area network (LAN) or a controlled lab environment.

Windows Tools: Wireshark, NetworkMiner (Free Edition).

Kali Linux Tools: tcpdump.

Sample Data: A .pcap file containing various protocols (HTTP, DNS, FTP, etc.).

Theoretical Background:
Network forensics involves the monitoring and analysis of computer network traffic. We rely on the OSI Model to understand where the data lives.

Packet Capture (PCAP): The standard format for recorded network traffic.

Protocols: We look for "insecure" protocols like HTTP, FTP, Telnet, and SMTP which transmit data in cleartext.

Flow Analysis: Identifying who talked to whom, for how long, and how much data was moved (crucial for detecting data exfiltration).


YouTube Guide: Network Forensics with Wireshark and NetworkMiner

Implementation 1: Windows Environment
Tool A: Wireshark (The Microscope)
Capture: Open Wireshark. Select your active Network Interface (e.g., Wi-Fi or Ethernet). Click the blue shark fin to start capturing.

Filter: Use the filter bar to isolate specific traffic.

http: Shows only web traffic.

ip.addr == [Suspect_IP]: Shows all traffic to/from a specific machine.

dns: Shows all website lookups (good for finding C2 - Command and Control servers).

Follow Stream: Right-click a TCP packet -> Follow -> TCP Stream. This reconstructs the "conversation" in a readable format.

Export Objects: Go to File -> Export Objects -> HTTP. You can literally "re-download" files the suspect downloaded during the capture.

Tool B: NetworkMiner (The Automated Investigator)
Load: Open NetworkMiner. Go to File -> Open and select your saved .pcap file.

Artifact Discovery: Unlike Wireshark, NetworkMiner is "artifact-centric."

Files Tab: Automatically lists every file transferred over the network (images, EXEs, docs).

Images Tab: Shows a gallery of images viewed by the user.

Credentials Tab: Automatically extracts usernames and passwords from unencrypted logins.

Observation: Use this to quickly see what was taken, while Wireshark tells you how.
Implementation 2: Kali Linux Environment
Tool C: tcpdump (The High-Speed Recorder)
In a high-traffic data center, a GUI tool like Wireshark will crash your system. Elite investigators use tcpdump for the heavy lifting.
Live Capture: ```bash
sudo tcpdump -i eth0 -w internal_investigation.pcap
* `-i`: Interface.
* `-w`: Write to file.
Filtered Capture (Targeted): ```bash
sudo tcpdump -i eth0 port 80 or port 443 -v
This captures only web traffic with "verbose" output.
Read and Filter: ```bash
tcpdump -r internal_investigation.pcap 'tcp port 80 and src 192.168.1.5'
This reads the file and shows only traffic from a specific suspect's IP on port 80.

