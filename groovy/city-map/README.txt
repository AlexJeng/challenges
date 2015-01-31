I resolved the problem using Groovy because there is a very good
Java - Groovy interoperability.

I implemented my own adjacency list as data structure for the city graph.
My implementation is based in other suggested by Guido van Rossum using Maps
to associate each vertex in a graph. Python Patterns - Implementing Graphs:
http://www.python.org/doc/essays/graphs/

I use Spock as testing and specification framework:
https://code.google.com/p/spock/

I use Gradle as project automation tool:
http://www.gradle.org/

Run all test:
    $ gradlew test
