# Practical 4: Analysis of DNS Traffic

## Aim
Capture DNS traffic and analyze query/response structure in Wireshark.

## Part 1: Capture DNS Traffic

1. Open Wireshark and start capture on an active interface.
2. Clear DNS cache in Command Prompt.

```bat
ipconfig /flushdns
```

3. Start interactive nslookup.

```bat
nslookup
```

4. Query a domain such as www.cisco.com.
5. Exit nslookup.

```text
exit
```

## Part 2: Explore DNS Query Traffic

1. Apply Wireshark filter.

```text
udp.port == 53
```

2. Select DNS packet: Standard query ... A www.cisco.com.
3. Inspect these layers in Packet Details:
- Ethernet II
- IPv4
- UDP
- DNS (query)

4. Record source and destination:
- MAC addresses
- IP addresses
- UDP ports

5. Run local checks for comparison.

```bat
arp -a
ipconfig /all
```

6. Compare packet values with local interface and gateway details.

## Part 3: Explore DNS Response Traffic

1. Select matching response packet: Standard query response ... A www.cisco.com.
2. Expand DNS response sections:
- Flags
- Queries
- Answers

3. Confirm returned A record(s), recursion behavior, and transaction linkage.

## Expected Result
- DNS query from local host to DNS server on UDP 53 is visible.
- Matching response packet includes resolved IP data for the queried domain.
