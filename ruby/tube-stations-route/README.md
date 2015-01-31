## Tube Stations Route

Write a Ruby program which finds the best route between two London tube stations.

Rules:

- You will need to build your own tube network. Feel free to use any source.
- You are given a list of London tube station pairs.
- All the edges which connect two stations have cost 1.
- Changing tube line in the same station has cost 1.
- Read the list from standard input and write to standard output the path with the lowest cost, comma separated.
- If there are more than one shortest routes, choose any.
- Abort if an illegal pair is read

Sample input:

    Liverpool Street,Brixton
    Oxford Circus,Waterloo

Sample output:

    Liverpool Street,Bank,Waterloo,Kennington,Oval,Stockwell,Brixton
    Oxford Circus,Green Park,Westminster,Waterloo

Bonus (optional): build a simple REST API on top of the program so that it's possible to query the service from a HTTP client
