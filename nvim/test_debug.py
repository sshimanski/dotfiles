#!/usr/bin/env python3

def fibonacci(n):
    """Calculate the nth Fibonacci number"""
    if n <= 1:
        return n
    else:
        return fibonacci(n-1) + fibonacci(n-2)


def main():
    print("Fibonacci sequence:")
    for i in range(10):
        print(f"fibonacci({i}) = {fibonacci(i)}")


if __name__ == "__main__":
    main()
