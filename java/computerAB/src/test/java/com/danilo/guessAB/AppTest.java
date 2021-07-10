package com.danilo.guessAB;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

/**
 * Unit test for simple App.
 */
public class AppTest 
{
    /**
     * Rigorous Test :-)
     */
    @Test
    public void testgetA()
    {
        int result = App.getA("1234", "1234");
        Assertions.assertEquals(4, result);
    }

    @Test
    public void testgetB()
    {
        int result = App.getB("1234", "4321");
        Assertions.assertEquals(4, result);
    }    
}
