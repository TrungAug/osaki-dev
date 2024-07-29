package asm.osaki.service;

import org.springframework.stereotype.Component;

@Component
public class VisitorCounter {
	private int count = 0;

    public synchronized void increment() {
        count++;
    }

    public synchronized int getCount() {
        return count;
    }
}
