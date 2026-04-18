# Practical 4: Analysis of DNS Traffic

## Aim
Capture DNS traffic and analyze DNS query and response structure in Wireshark.

## Tips
- Use CyberOps Workstation and make sure Wireshark is available.

## Part 1: Capture DNS Traffic

1. Open Wireshark and start capture on an active network interface.

2. Open Command Prompt and clear DNS cache.

```bat
ipconfig /flushdns
```

3. Generate DNS query traffic with nslookup.

```bat
nslookup www.cisco.com
```

4. Return to Wireshark and stop capture after the lookup completes.

## Part 2: Analyze DNS Query Packet

1. Apply DNS display filter.

```text
udp.port == 53
```

2. Select packet labeled similar to:
- Standard query ... A www.cisco.com

3. Expand packet details and record values from:
- Ethernet II: source and destination MAC
- Internet Protocol Version 4: source and destination IP
- User Datagram Protocol: source and destination ports
- Domain Name System (query): flags and query name

4. View ARP table from system.

```bat
arp -a
```

5. View full IP configuration.

```bat
ipconfig /all
```

6. Confirm whether Wireshark packet values match local NIC/gateway and DNS server path.

## Part 3: Analyze DNS Response Packet

1. Select matching response packet labeled similar to:
- Standard query response ... A www.cisco.com

2. Expand DNS response sections:
- Flags
- Queries
- Answers

3. Verify returned A record values and confirm response corresponds to the earlier query.

## Expected Result
- DNS query from local host to DNS server on UDP port 53 is captured.
- Corresponding DNS response packet includes resolved IP address data.

## Notes
- Filter `dns` can also be used if needed, but `udp.port == 53` keeps focus on DNS-over-UDP packets.
