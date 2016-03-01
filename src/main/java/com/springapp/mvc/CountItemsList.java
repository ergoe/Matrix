package com.springapp.mvc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Eric on 2/29/16.
 */
public class CountItemsList<E> extends ArrayList<E> {

    private Map<E, Integer> count = new HashMap<E, Integer>();

    public boolean add( E element) {
        if (!count.containsKey(element)) {
            count.put(element, 1);
        } else {
            count.put(element, count.get(element) + 1);
        }
        return super.add(element);
    }

    public int getCount( E element) {
        if( !count.containsKey(element)) {
            return 0;
        } else {
            return count.get(element);
        }
    }

}
