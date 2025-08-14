package com.oab.ipay.avail;

import java.lang.reflect.Field;
import java.util.Collection;

import org.json.JSONArray;
import org.json.JSONObject;

public class JsonUtil {

    public static JSONObject objectToJson(Object obj) throws Exception {
        JSONObject jsonObject = new JSONObject();
        try {
            Class<?> clazz = obj.getClass();
            Field[] fields = clazz.getDeclaredFields();
            for (Field field : fields) {
                field.setAccessible(true);
                Object value = field.get(obj);
                if (value instanceof Collection) {
                    JSONArray jsonArray = new JSONArray();
                    for (Object item : (Collection<?>) value) {
                        jsonArray.put(objectToJson(item));
                    }
                    jsonObject.put(field.getName(), jsonArray);
                }
                else if (value != null && !isPrimitiveOrWrapper(value.getClass())) {
                    jsonObject.put(field.getName(), objectToJson(value));
                } else {
                    jsonObject.put(field.getName(), value);
                }
            }
        } catch (IllegalAccessException e) {
            throw new RuntimeException("Error during serialization", e);
        }
 
        return jsonObject;
    }
 
    private static boolean isPrimitiveOrWrapper(Class<?> clazz) {
        return clazz.isPrimitive() || clazz == String.class || clazz == Boolean.class ||
                clazz == Integer.class || clazz == Long.class || clazz == Double.class ||
                clazz == Float.class || clazz == Character.class || clazz == Byte.class ||
                clazz == Short.class || clazz == Void.class;
    }
}
