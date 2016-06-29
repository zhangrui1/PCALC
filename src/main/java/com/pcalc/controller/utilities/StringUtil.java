package com.pcalc.controller.utilities;

import java.io.UnsupportedEncodingException;
import java.util.List;

/**
 * Created by zhangrui on 2015/04/09.
 */
public class StringUtil {

    /**
     * 指定文字列が空文字列であるか否かの検証
     *
     * @param value
     *            文字列
     * @return　検証結果のブール値
     */
    public static boolean isEmpty(String value) {
        return value == null || value.length() == 0;
    }

    /**
     * 指定文字列が空文字列でないか否かの検証
     *
     * @param value
     *            文字列
     * @return 検証結果のブール値
     */
    public static boolean isNotEmpty(String value) {
        return value != null && value.length() != 0;
    }

    /**
     * 文字列を結合する
     *
     * @param buff
     *            対象文字列を格納する配列
     * @return　結合後の文字列
     */
    public static String concat(String... buff) {
        StringBuffer sb = new StringBuffer("");
        for (String value : buff) {
            if (isNotEmpty(value)) {
                if (sb.length() != 0) {
                    sb.append(" ");
                }
                sb.append(value);
            }
        }
        return sb.toString();
    }

    /**
     * 文字列を結合する
     *
     * @param delimit
     *            デリミタ文字列
     * @param buff
     *            対象文字列を格納する配列
     * @return　結合後の文字列
     */
    public static String concatWithDelimit(String delimit, String... buff) {
        StringBuffer sb = new StringBuffer("");
        for (String value : buff) {
            if (isNotEmpty(value)) {
                if (sb.length() != 0) {
                    sb.append(delimit);
                }
                sb.append(value);
            }
        }
        return sb.toString();
    }
    /**
     * 文字列を結合する
     *
     * @param list
     *            対象文字列を格納する配列
     * @return　結合後の文字列
     */
    public static String concat(List<String> list) {
        StringBuffer sb = new StringBuffer("");
        for (String value : list) {
            if (isNotEmpty(value)) {
                if (sb.length() != 0) {
                    sb.append(" ");
                }
                sb.append(value);
            }
        }
        return sb.toString();
    }
    /**
     * 文字列を文字化けから戻す
     *
     * @param targetString
     *            対象文字列
     * @return　変換後の文字列
     */
    public static String changeToUTF8(String targetString) throws UnsupportedEncodingException {

        if(isNotEmpty(targetString)){
            targetString= new String(targetString.getBytes("ISO_8859_1"), "UTF-8");
            return targetString;
        }else{
            return "";
        }
    }

}
