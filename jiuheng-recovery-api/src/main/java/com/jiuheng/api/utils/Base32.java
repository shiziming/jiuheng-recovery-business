/* --------------------------------------------------------
 * Copyright (C) Home.
 * All rights reserved.
 *
 * User: yunlong
 * Date: 2014年10月22日 下午9:41:29
 *
 * Version: Base32.java
 * --------------------------------------------------------
 */

/**
 * 
 */
package com.jiuheng.api.utils;

import java.util.HashMap;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.locks.ReentrantLock;

/**
 * @author wangyunlong
 * 
 */
public final class Base32 {
	// //////////////////////////////////////////////////////////
	// 内嵌类。
	// //////////////////////////////////////////////////////////
	private static class Node {
		/**
		 * 字符集合。
		 */
		char[] list_char;

		int offset;

		int max;

		/**
		 * 链接节点。
		 */
		Node next;

		/**
		 * 构造节点。
		 */
		Node() {
			this.list_char = new char[Base32.MAX_LENGTH_LONG];
			this.offset = 0;
			this.max = 0;
			this.next = null;
		}

		/**
		 * 输出转换字符串。
		 * 
		 * @return
		 */
		String output() {
			return new String(this.list_char, this.offset, this.max - this.offset);
		}

		/**
		 * 输出转换字符串。
		 * 
		 * @param length
		 *            固定长度。
		 * @return
		 */
		String output(int length) {
			int count = this.max - this.offset;
			if (count < length) {
				for (int i = this.offset - (length - count); i < this.offset; i++) {
					this.list_char[i] = '0';
				}
				this.offset -= length - count;
			}
			return new String(this.list_char, this.offset, this.max - this.offset);
		}

		/**
		 * 输出转换字符串。
		 * 
		 * @param buff
		 *            输出缓存。
		 * @return
		 */
		int output(StringBuilder buff) {
			int count = this.max - this.offset;
			buff.append(this.list_char, this.offset, count);
			return count;
		}

		/**
		 * 输出转换字符串。
		 * 
		 * @param buff
		 *            输出缓存。
		 * @param length
		 *            固定长度。
		 * @return
		 */
		int output(StringBuilder buff, int length) {
			int count = this.max - this.offset;
			if (count < length) {
				for (int i = this.offset - (length - count); i < this.offset; i++) {
					this.list_char[i] = '0';
				}
				this.offset -= length - count;
			}
			count = this.max - this.offset;
			buff.append(this.list_char, this.offset, count);
			return count;
		}

		/**
		 * 释放节点。
		 */
		void release() {
			Base32.lock.lock();
			this.next = Base32.head.next;
			Base32.head.next = this;
			Base32.lock.unlock();
			return;
		}
	}

	// //////////////////////////////////////////////////////////
	// 静态变量。
	// //////////////////////////////////////////////////////////
	/**
	 * 缓存节点。
	 */
	private static final ReentrantLock lock = new ReentrantLock();

	private static final Node head = new Node();

	private static final int MAX_LENGTH_BYTE = 2;

	private static final int MAX_LENGTH_SHORT = 4;

	private static final int MAX_LENGTH_INT = 7;

	private static final int MAX_LENGTH_LONG = 13;

	/**
	 * 字符映射。
	 */
	protected static final char[] CHAR_SET_STD = "0123456789ABCDEFGHJKLMNPQRSTUWXY".toCharArray();

	private static final HashMap<Integer, Integer> HASH_BASE32 = new HashMap<Integer, Integer>(64);

	private static final HashMap<Integer, Integer> HASH_BASE32_MOD2 = new HashMap<Integer, Integer>(16);

	private static final HashMap<Integer, Integer> HASH_BASE32_MOD4 = new HashMap<Integer, Integer>();

	private static final HashMap<Integer, Integer> HASH_BASE32_MOD5 = new HashMap<Integer, Integer>(32);

	private static final HashMap<Integer, Integer> HASH_BASE32_MOD7 = new HashMap<Integer, Integer>();

	private static final String[] STRING_SET_CHAR_STD = new String[32];

	private static final String[] LIST_STR_ZERO = { "0", "0", "00", "000", "0000", "00000", "000000", "0000000", "00000000", "000000000", "0000000000", "00000000000",
	        "000000000000", "0000000000000" };

	static {
		String str = "0123456789ABCDEFGHJKLMNPQRSTUWXY";
		char c = '\0';
		int value = 0;
		for (int i = 0; i < CHAR_SET_STD.length; i++) {
			Base32.STRING_SET_CHAR_STD[i] = str.substring(i, i + 1);
			c = CHAR_SET_STD[i];
			value = c;
			Base32.HASH_BASE32.put(value, i);
		}
		// 构造Base32补码字符集。
		int index = 0;
		for (int i = 0; i < 8; i++) {
			index = i * 4;
			value = CHAR_SET_STD[index];
			Base32.HASH_BASE32_MOD2.put(value, index);
		}
		for (int i = 0; i < 2; i++) {
			index = i * 16;
			value = CHAR_SET_STD[index];
			Base32.HASH_BASE32_MOD4.put(value, index);
		}
		for (int i = 0; i < 16; i++) {
			index = i * 2;
			value = CHAR_SET_STD[index];
			Base32.HASH_BASE32_MOD5.put(value, index);
		}
		for (int i = 0; i < 4; i++) {
			index = i * 8;
			value = CHAR_SET_STD[index];
			Base32.HASH_BASE32_MOD7.put(value, index);
		}
	}

	// //////////////////////////////////////////////////////////
	// 成员函数 - 字符输出缓存。
	// //////////////////////////////////////////////////////////
	/**
	 * 缓存。
	 */
	private static final LinkedBlockingQueue<StringBuilder> cached_buff = new LinkedBlockingQueue<StringBuilder>(2048);

	/**
	 * 获取字符输出缓存。
	 * 
	 * @return
	 */
	private static final StringBuilder pollStringBuilder() {
		StringBuilder buff = Base32.cached_buff.poll();
		if (null == buff) {
			buff = new StringBuilder();
		} else {
			buff.delete(0, buff.capacity());
		}
		return buff;
	}

	// //////////////////////////////////////////////////////////
	// 静态函数 － 节点缓存。
	// //////////////////////////////////////////////////////////
	/**
	 * 获取字符串缓存。
	 * 
	 * @return
	 */
	private static final Node poll() {
		Base32.lock.lock();
		Node node = Base32.head.next;
		if (null == node) {
			node = new Node();
		} else {
			Base32.head.next = node.next;
			node.next = null;
		}
		Base32.lock.unlock();
		return node;
	}

	// //////////////////////////////////////////////////////////
	// 成员函数 - 参数核查。
	// //////////////////////////////////////////////////////////
	/**
	 * 是否合规Base32字符串。
	 * 
	 * @param data
	 *            ASCII字符串
	 * @return >0 转换后数据长度； <=0 违规字符串，含不可识别字符。
	 * @throws NullPointerException
	 *             null == data 时, 抛出该异常。
	 */
	public static final int isValidBase32Char(String data) throws NullPointerException {
		HashMap<Integer, Integer> charset = Base32.HASH_BASE32;
		int length = data.length();
		if (0 == length) {
			return 0;
		}
		// 核查补位字符。
		int mod = length % 8, c = 0, ret = length / 8 * 5;
		length = length / 8 * 8;
		// 核查完整字符组。
		for (int i = 0; i < length; i++) {
			c = data.charAt(i);
			if (null == charset.get(c)) {
				return 0;
			}
		}
		// 核查末尾字符。
		switch (mod) {
		case 2:
			charset = Base32.HASH_BASE32_MOD2;
			ret += 1;
			break; // switch (mod) {
		case 4:
			charset = Base32.HASH_BASE32_MOD4;
			ret += 2;
			break; // switch (mod) {
		case 5:
			charset = Base32.HASH_BASE32_MOD5;
			ret += 3;
			break; // switch (mod) {
		case 7:
			charset = Base32.HASH_BASE32_MOD7;
			ret += 4;
			break; // switch (mod) {
		default:
			return 0;
		}
		for (int i = 0; i < mod; i++) {
			c = data.charAt(length + i);
			if (null == charset.get(c)) {
				return 0;
			}
		}
		return ret;
	}

	/**
	 * 是否合规Base32字符串。
	 * 
	 * @param data
	 *            ASCII字符串
	 * @param offset
	 *            偏移量。
	 * @param length
	 *            长度。
	 * @return >0 转换后数据长度； <=0 违规字符串，含不可识别字符。
	 * @throws NullPointerException
	 *             null == data || null == buff 时, 抛出该异常。
	 * @throws IndexOutOfBoundsException
	 *             offset < 0 || length < 0 || offset + length > data.length 时, 抛出该异常。
	 */
	public static final int isValidBase32Char(byte[] data, int offset, int length) throws IndexOutOfBoundsException, NullPointerException {
		if (length <= 0) {
			return 0;
		}
		HashMap<Integer, Integer> charset = Base32.HASH_BASE32;
		// 核查补位字符。
		int mod = length % 8, c = 0, ret = length / 8 * 5;
		int limit = offset + length / 8 * 8;
		// 核查完整字符组。
		for (int i = offset; i < limit; i++) {
			c = data[i];
			if (null == charset.get(c)) {
				return 0;
			}
		}
		// 核查末尾字符。
		switch (mod) {
		case 2:
			charset = Base32.HASH_BASE32_MOD2;
			ret += 1;
			break; // switch (mod) {
		case 4:
			charset = Base32.HASH_BASE32_MOD4;
			ret += 2;
			break; // switch (mod) {
		case 5:
			charset = Base32.HASH_BASE32_MOD5;
			ret += 3;
			break; // switch (mod) {
		case 7:
			charset = Base32.HASH_BASE32_MOD7;
			ret += 4;
			break; // switch (mod) {
		default:
			return 0;
		}
		for (int i = 0; i < mod; i++) {
			c = data[limit + i];
			if (null == charset.get(c)) {
				return 0;
			}
		}
		return ret;
	}

	/**
	 * binary to ascii 编码长度。
	 * 
	 * @param length
	 *            数据长度，单位字节(Byte)。
	 * @return 编码长度。<=0 参数错误。
	 */
	public static final int sizeEncode(int length) {
		if (length <= 0) {
			return 0;
		}
		int mod = length % 5, div = length / 5;
		switch (mod) {
		case 0:
			length = div * 8;
			break; // switch (mod) {
		case 1:
			length = div * 8 + 2;
			break; // switch (mod) {
		case 2:
			length = div * 8 + 4;
			break; // switch (mod) {
		case 3:
			length = div * 8 + 5;
			break; // switch (mod) {
		case 4:
			length = div * 8 + 7;
			break; // switch (mod) {
		}
		return length;
	}

	/**
	 * ascii to binary 解码长度。
	 * 
	 * @param length
	 *            数据长度，单位字节(Byte)。
	 * @return 解码长度。<=0 参数错误。
	 */
	public static final int sizeDecode(int length) {
		if (length <= 0) {
			return 0;
		}
		int mod = length % 8, div = length / 8;
		switch (mod) {
		case 0:
			length = div * 5;
			break; // switch (mod) {
		case 2:
			length = div * 5 + 1;
			break; // switch (mod) {
		case 4:
			length = div * 5 + 2;
			break; // switch (mod) {
		case 5:
			length = div * 5 + 3;
			break; // switch (mod) {
		case 7:
			length = div * 5 + 4;
			break; // switch (mod) {
		default:
			return 0;
		}
		return length;
	}

	// //////////////////////////////////////////////////////////
	// 静态函数 － encode。
	// //////////////////////////////////////////////////////////
	/**
	 * 编码基础值，前导0不输出。
	 * 
	 * @param value
	 *            值。
	 * @return
	 */
	private static final Node encodeInt(int value) {
		int poi = 0;
		Node node = Base32.poll();
		node.max = Base32.MAX_LENGTH_INT;
		node.offset = node.max;
		while (0 != value) {
			node.offset--;
			poi = 0x1F & value;
			node.list_char[node.offset] = Base32.CHAR_SET_STD[poi];
			value = value >>> 5;
		}
		return node;
	}

	/**
	 * 编码基础值，前导0不输出。
	 * 
	 * @param value
	 *            值。
	 * @return
	 */
	private static final Node encodeLong(long value) {
		long poi = 0;
		Node node = Base32.poll();
		node.max = Base32.MAX_LENGTH_LONG;
		node.offset = node.max;
		while (0L != value) {
			node.offset--;
			poi = 0x1FL & value;
			node.list_char[node.offset] = Base32.CHAR_SET_STD[(int) poi];
			value = value >>> 5;
		}
		return node;
	}

	/**
	 * 编码基础值，前导0不输出。
	 * 
	 * @param value
	 *            值。
	 * @return Base32编码值。
	 */
	public static final String encodeByteToBase32(byte value) {
		if (0 == value) {
			return Base32.STRING_SET_CHAR_STD[0];
		}
		Node node = Base32.encodeInt(0xFF & value);
		String str = node.output();
		node.release();
		return str;
	}

	/**
	 * 编码基础值。
	 * 
	 * @param value
	 *            值。
	 * @param length
	 *            固定长度，最长2字符。
	 * @return Base32编码值。
	 */
	public static final String encodeByteToBase32(byte value, int length) {
		if (0 == value) {
			if (length > Base32.MAX_LENGTH_BYTE) {
				return Base32.LIST_STR_ZERO[Base32.MAX_LENGTH_BYTE];
			} else {
				return Base32.LIST_STR_ZERO[length];
			}
		}
		Node node = Base32.encodeInt(0xFF & value);
		String str = null;
		if (length > Base32.MAX_LENGTH_BYTE) {
			str = node.output(Base32.MAX_LENGTH_BYTE);
		} else {
			str = node.output(length);
		}
		node.release();
		return str;
	}

	/**
	 * 编码基础值。
	 * 
	 * @param value
	 *            值。
	 * @param buff
	 *            输出缓存。
	 * @return 编码长度。
	 * @throws NullPointerException
	 *             null == buff 时，抛出该异常。
	 */
	public static final int encodeByteToBase32(byte value, StringBuilder buff) throws NullPointerException {
		if (0 == value) {
			buff.append(Base32.CHAR_SET_STD[0]);
			return 1;
		}
		Node node = Base32.encodeInt(0xFF & value);
		int length = node.output(buff);
		node.release();
		return length;
	}

	/**
	 * 编码基础值。
	 * 
	 * @param value
	 *            值。
	 * @param length
	 *            固定长度，最长2字符。
	 * @param buff
	 *            输出缓存。
	 * @return 编码长度。
	 * @throws NullPointerException
	 *             null == buff 时，抛出该异常。
	 */
	public static final int encodeByteToBase32(byte value, int length, StringBuilder buff) throws NullPointerException {
		int count = 0;
		if (0 == value) {
			if (length > Base32.MAX_LENGTH_BYTE) {
				count = Base32.MAX_LENGTH_BYTE;
				buff.append(Base32.LIST_STR_ZERO[Base32.MAX_LENGTH_BYTE]);
			} else if (length < 1) {
				count = 1;
				buff.append(Base32.LIST_STR_ZERO[1]);
			} else {
				count = length;
				buff.append(Base32.LIST_STR_ZERO[length]);
			}
			return count;
		}
		Node node = Base32.encodeInt(0xFF & value);
		if (length > Base32.MAX_LENGTH_BYTE) {
			count = node.output(buff, Base32.MAX_LENGTH_BYTE);
		} else {
			count = node.output(buff, length);
		}
		node.release();
		return count;
	}

	/**
	 * 编码基础值，前导0不输出。
	 * 
	 * @param value
	 *            值。
	 * @return Base32编码值。
	 */
	public static final String encodeShortToBase32(short value) {
		if (0 == value) {
			return Base32.STRING_SET_CHAR_STD[0];
		}
		Node node = Base32.encodeInt(0xFFFF & value);
		String str = node.output();
		node.release();
		return str;
	}

	/**
	 * 编码基础值。
	 * 
	 * @param value
	 *            值。
	 * @param length
	 *            固定长度，最长4字符。
	 * @return Base32编码值。
	 */
	public static final String encodeShortToBase32(short value, int length) {
		if (0 == value) {
			if (length > Base32.MAX_LENGTH_SHORT) {
				return Base32.LIST_STR_ZERO[Base32.MAX_LENGTH_SHORT];
			} else {
				return Base32.LIST_STR_ZERO[length];
			}
		}
		Node node = Base32.encodeInt(0xFFFF & value);
		String str = null;
		if (length > Base32.MAX_LENGTH_SHORT) {
			str = node.output(Base32.MAX_LENGTH_SHORT);
		} else {
			str = node.output(length);
		}
		node.release();
		return str;
	}

	/**
	 * 编码基础值。
	 * 
	 * @param value
	 *            值。
	 * @param buff
	 *            输出缓存。
	 * @return 编码长度。
	 * @throws NullPointerException
	 *             null == buff 时，抛出该异常。
	 */
	public static final int encodeShortToBase32(short value, StringBuilder buff) throws NullPointerException {
		if (0 == value) {
			buff.append(Base32.CHAR_SET_STD[0]);
			return 1;
		}
		Node node = Base32.encodeInt(0xFFFF & value);
		int length = node.output(buff);
		node.release();
		return length;
	}

	/**
	 * 编码基础值。
	 * 
	 * @param value
	 *            值。
	 * @param length
	 *            固定长度，最长4字符。
	 * @param buff
	 *            输出缓存。
	 * @return 编码长度。
	 * @throws NullPointerException
	 *             null == buff 时，抛出该异常。
	 */
	public static final int encodeShortToBase32(short value, int length, StringBuilder buff) throws NullPointerException {
		int count = 0;
		if (0 == value) {
			if (length > Base32.MAX_LENGTH_SHORT) {
				count = Base32.MAX_LENGTH_SHORT;
				buff.append(Base32.LIST_STR_ZERO[Base32.MAX_LENGTH_SHORT]);
			} else if (length < 1) {
				count = 1;
				buff.append(Base32.LIST_STR_ZERO[1]);
			} else {
				count = length;
				buff.append(Base32.LIST_STR_ZERO[length]);
			}
			return count;
		}
		Node node = Base32.encodeInt(0xFFFF & value);
		if (length > Base32.MAX_LENGTH_SHORT) {
			count = node.output(buff, Base32.MAX_LENGTH_SHORT);
		} else {
			count = node.output(buff, length);
		}
		node.release();
		return count;
	}

	/**
	 * 编码基础值，前导0不输出。
	 * 
	 * @param value
	 *            值。
	 * @return Base32编码值。
	 */
	public static final String encodeIntToBase32(int value) {
		if (0 == value) {
			return Base32.STRING_SET_CHAR_STD[0];
		}
		Node node = Base32.encodeInt(value);
		String str = node.output();
		node.release();
		return str;
	}

	/**
	 * 编码基础值。
	 * 
	 * @param value
	 *            值。
	 * @param length
	 *            固定长度，最长7字符。
	 * @return Base32编码值。
	 */
	public static final String encodeIntToBase32(int value, int length) {
		if (0 == value) {
			if (length > Base32.MAX_LENGTH_INT) {
				return Base32.LIST_STR_ZERO[Base32.MAX_LENGTH_INT];
			} else {
				return Base32.LIST_STR_ZERO[length];
			}
		}
		Node node = Base32.encodeInt(value);
		String str = null;
		if (length > Base32.MAX_LENGTH_INT) {
			str = node.output(Base32.MAX_LENGTH_INT);
		} else {
			str = node.output(length);
		}
		node.release();
		return str;
	}

	/**
	 * 编码基础值。
	 * 
	 * @param value
	 *            值。
	 * @param buff
	 *            输出缓存。
	 * @return 编码长度。
	 * @throws NullPointerException
	 *             null == buff 时，抛出该异常。
	 */
	public static final int encodeIntToBase32(int value, StringBuilder buff) throws NullPointerException {
		if (0 == value) {
			buff.append(Base32.CHAR_SET_STD[0]);
			return 1;
		}
		Node node = Base32.encodeInt(value);
		int length = node.output(buff);
		node.release();
		return length;
	}

	/**
	 * 编码基础值。
	 * 
	 * @param value
	 *            值。
	 * @param length
	 *            固定长度，最长7字符。
	 * @param buff
	 *            输出缓存。
	 * @return 编码长度。
	 * @throws NullPointerException
	 *             null == buff 时，抛出该异常。
	 */
	public static final int encodeIntToBase32(int value, int length, StringBuilder buff) throws NullPointerException {
		int count = 0;
		if (0 == value) {
			if (length > Base32.MAX_LENGTH_INT) {
				count = Base32.MAX_LENGTH_INT;
				buff.append(Base32.LIST_STR_ZERO[Base32.MAX_LENGTH_INT]);
			} else if (length < 1) {
				count = 1;
				buff.append(Base32.LIST_STR_ZERO[1]);
			} else {
				count = length;
				buff.append(Base32.LIST_STR_ZERO[length]);
			}
			return count;
		}
		Node node = Base32.encodeInt(value);
		if (length > Base32.MAX_LENGTH_INT) {
			count = node.output(buff, Base32.MAX_LENGTH_INT);
		} else {
			count = node.output(buff, length);
		}
		node.release();
		return count;
	}

	/**
	 * 编码基础值，前导0不输出。
	 * 
	 * @param value
	 *            值。
	 * @return Base32编码值。
	 */
	public static final String encodeLongToBase32(long value) {
		if (0 == value) {
			return Base32.STRING_SET_CHAR_STD[0];
		}
		Node node = Base32.encodeLong(value);
		String str = node.output();
		node.release();
		return str;
	}

	/**
	 * 编码基础值。
	 * 
	 * @param value
	 *            值。
	 * @param length
	 *            固定长度，最长13字符。
	 * @return Base32编码值。
	 */
	public static final String encodeLongToBase32(long value, int length) {
		if (0 == value) {
			if (length > Base32.MAX_LENGTH_LONG) {
				return Base32.LIST_STR_ZERO[Base32.MAX_LENGTH_LONG];
			} else {
				return Base32.LIST_STR_ZERO[length];
			}
		}
		Node node = Base32.encodeLong(value);
		String str = null;
		if (length > Base32.MAX_LENGTH_LONG) {
			str = node.output(Base32.MAX_LENGTH_LONG);
		} else {
			str = node.output(length);
		}
		node.release();
		return str;
	}

	/**
	 * 编码基础值。
	 * 
	 * @param value
	 *            值。
	 * @param buff
	 *            输出缓存。
	 * @return 编码长度。
	 * @throws NullPointerException
	 *             null == buff 时，抛出该异常。
	 */
	public static final int encodeLongToBase32(long value, StringBuilder buff) throws NullPointerException {
		if (0 == value) {
			buff.append(Base32.CHAR_SET_STD[0]);
			return 1;
		}
		Node node = Base32.encodeLong(value);
		int length = node.output(buff);
		node.release();
		return length;
	}

	/**
	 * 编码基础值。
	 * 
	 * @param value
	 *            值。
	 * @param length
	 *            固定长度，最长13字符。
	 * @param buff
	 *            输出缓存。
	 * @return 编码长度。
	 * @throws NullPointerException
	 *             null == buff 时，抛出该异常。
	 */
	public static final int encodeLongToBase32(long value, int length, StringBuilder buff) throws NullPointerException {
		int count = 0;
		if (0 == value) {
			if (length > Base32.MAX_LENGTH_LONG) {
				count = Base32.MAX_LENGTH_LONG;
				buff.append(Base32.LIST_STR_ZERO[Base32.MAX_LENGTH_LONG]);
			} else if (length < 1) {
				count = 1;
				buff.append(Base32.LIST_STR_ZERO[1]);
			} else {
				count = length;
				buff.append(Base32.LIST_STR_ZERO[length]);
			}
			return count;
		}
		Node node = Base32.encodeLong(value);
		if (length > Base32.MAX_LENGTH_LONG) {
			count = node.output(buff, Base32.MAX_LENGTH_LONG);
		} else {
			count = node.output(buff, length);
		}
		node.release();
		return count;
	}

	/**
	 * 编码二进制数据。
	 * 
	 * @param data
	 *            数据。
	 * @param offset
	 *            偏移量。
	 * @param length
	 *            数据长度。
	 * @return null 参数错误；other Base32编码值。
	 * @throws NullPointerException
	 *             null == data 时，抛出该异常。
	 * @throws IndexOutOfBoundsException
	 *             offset < 0 || length < 0 || offset + length > data.length 时, 抛出该异常。
	 */
	public static final String encodeBytesToBase32(byte[] data, int offset, int length) throws NullPointerException, IndexOutOfBoundsException {
		if (0 == length) {
			return null;
		}
		StringBuilder buff = Base32.pollStringBuilder();
		Base32.encodeBytesToBase32(data, offset, length, buff);
		String value = buff.toString();
		Base32.cached_buff.offer(buff);
		return value;
	}

	/**
	 * 编码二进制数据。
	 * 
	 * @param data
	 *            数据。
	 * @param offset
	 *            偏移量。
	 * @param length
	 *            数据长度。
	 * @param buff
	 *            输出缓存。
	 * @return 编码长度。
	 * @throws NullPointerException
	 *             null == data 时，抛出该异常。
	 * @throws IndexOutOfBoundsException
	 *             offset < 0 || length < 0 || offset + length > data.length 时, 抛出该异常。
	 */
	public static final int encodeBytesToBase32(byte[] data, int offset, int length, StringBuilder buff) throws NullPointerException, IndexOutOfBoundsException {
		if (0 == length) {
			return 0;
		}
		int div = length / 5, mod = length % 5, poi = offset, length_convert = 0, value = 0, index = 0;
		for (int i = 0; i < div; i++) {
			// byte 1
			index = 0xFF & data[poi++];
			value = index >> 3;
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index << 2);
			// byte 2
			index = 0xFF & data[poi++];
			value |= index >> 6;
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index >> 1);
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index << 4);
			// byte 3
			index = 0xFF & data[poi++];
			value |= index >> 4;
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index << 1);
			// byte 4
			index = 0xFF & data[poi++];
			value |= index >> 7;
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index >> 2);
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index << 3);
			// byte 5
			index = 0xFF & data[poi++];
			value |= index >> 5;
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & index;
			buff.append(Base32.CHAR_SET_STD[value]);
		}
		length_convert = div * 8;
		switch (mod) {
		case 1:
			index = 0xFF & data[poi++];
			value = index >> 3;
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index << 2);
			buff.append(Base32.CHAR_SET_STD[value]);
			length_convert += 2;
			break; // switch (mod) {
		case 2:
			// byte 1
			index = 0xFF & data[poi++];
			value = index >> 3;
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index << 2);
			// byte 2
			index = 0xFF & data[poi++];
			value |= index >> 6;
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index >> 1);
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index << 4);
			buff.append(Base32.CHAR_SET_STD[value]);
			length_convert += 4;
			break; // switch (mod) {
		case 3:
			// byte 1
			index = 0xFF & data[poi++];
			value = index >> 3;
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index << 2);
			// byte 2
			index = 0xFF & data[poi++];
			value |= index >> 6;
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index >> 1);
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index << 4);
			// byte 3
			index = 0xFF & data[poi++];
			value |= index >> 4;
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index << 1);
			buff.append(Base32.CHAR_SET_STD[value]);
			length_convert += 5;
			break; // switch (mod) {
		case 4:
			// byte 1
			index = 0xFF & data[poi++];
			value = index >> 3;
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index << 2);
			// byte 2
			index = 0xFF & data[poi++];
			value |= index >> 6;
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index >> 1);
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index << 4);
			// byte 3
			index = 0xFF & data[poi++];
			value |= index >> 4;
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index << 1);
			// byte 4
			index = 0xFF & data[poi++];
			value |= index >> 7;
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index >> 2);
			buff.append(Base32.CHAR_SET_STD[value]);
			value = 0x1F & (index << 3);
			buff.append(Base32.CHAR_SET_STD[value]);
			length_convert += 7;
			break; // switch (mod) {
		}
		return length_convert;
	}

	// //////////////////////////////////////////////////////////
	// 静态函数 － decode。
	// //////////////////////////////////////////////////////////
	/**
	 * 获取字符索引。
	 * 
	 * @param c
	 *            字符。
	 * @return <0 字符不支持。
	 */
	private static final int decodeChar(char c) {
		int value = c;
		Integer index = Base32.HASH_BASE32.get(value);
		if (null == index) {
			return -1;
		}
		return index.intValue();
	}

	/**
	 * 解码到基础值。
	 * 
	 * @param str
	 *            字符值。
	 * @return
	 */
	public static final byte decodeBase32ToByte(String str) {
		int end = str.length(), value = 0, tmp = 0;
		for (int i = end < Base32.MAX_LENGTH_BYTE ? 0 : end - Base32.MAX_LENGTH_BYTE; i < end; i++) {
			value = value << 5;
			tmp = Base32.decodeChar(str.charAt(i));
			value |= tmp;
		}
		return (byte) (0xFF & value);
	}

	/**
	 * 解码到基础值。
	 * 
	 * @param str
	 *            字符值。
	 * @param begin
	 *            开始位置，包含。
	 * @param end
	 *            结束位置，不包含。
	 * @return
	 */
	public static final byte decodeBase32ToByte(String str, int begin, int end) {
		int value = 0, tmp = 0;
		for (int i = end - begin < Base32.MAX_LENGTH_BYTE ? begin : end - Base32.MAX_LENGTH_BYTE; i < end; i++) {
			value = value << 5;
			tmp = Base32.decodeChar(str.charAt(i));
			value |= tmp;
		}
		return (byte) (0xFF & value);
	}

	/**
	 * 解码到基础值。
	 * 
	 * @param str
	 *            字符值。
	 * @return
	 */
	public static final short decodeBase32ToShort(String str) {
		int end = str.length(), value = 0, tmp = 0;
		for (int i = end < Base32.MAX_LENGTH_SHORT ? 0 : end - Base32.MAX_LENGTH_SHORT; i < end; i++) {
			value = value << 5;
			tmp = Base32.decodeChar(str.charAt(i));
			value |= tmp;
		}
		return (short) (0xFFFF & value);
	}

	/**
	 * 解码到基础值。
	 * 
	 * @param str
	 *            字符值。
	 * @param begin
	 *            开始位置，包含。
	 * @param end
	 *            结束位置，不包含。
	 * @return
	 */
	public static final short decodeBase32ToShort(String str, int begin, int end) {
		int value = 0, tmp = 0;
		for (int i = end - begin < Base32.MAX_LENGTH_SHORT ? begin : end - Base32.MAX_LENGTH_SHORT; i < end; i++) {
			value = value << 5;
			tmp = Base32.decodeChar(str.charAt(i));
			value |= tmp;
		}
		return (short) (0xFFFF & value);
	}

	/**
	 * 解码到基础值。
	 * 
	 * @param str
	 *            字符值。
	 * @return
	 */
	public static final int decodeBase32ToInt(String str) {
		int end = str.length(), value = 0, tmp = 0;
		for (int i = end < Base32.MAX_LENGTH_INT ? 0 : end - Base32.MAX_LENGTH_INT; i < end; i++) {
			value = value << 5;
			tmp = Base32.decodeChar(str.charAt(i));
			value |= tmp;
		}
		return value;
	}

	/**
	 * 解码到基础值。
	 * 
	 * @param str
	 *            字符值。
	 * @param begin
	 *            开始位置，包含。
	 * @param end
	 *            结束位置，不包含。
	 * @return
	 */
	public static final int decodeBase32ToInt(String str, int begin, int end) {
		int value = 0, tmp = 0;
		for (int i = end - begin < Base32.MAX_LENGTH_INT ? begin : end - Base32.MAX_LENGTH_INT; i < end; i++) {
			value = value << 5;
			tmp = Base32.decodeChar(str.charAt(i));
			value |= tmp;
		}
		return value;
	}

	/**
	 * 解码到基础值。
	 * 
	 * @param str
	 *            字符值。
	 * @return
	 */
	public static final long decodeBase32ToLong(String str) {
		int end = str.length(), tmp = 0;
		long value = 0L;
		for (int i = end < Base32.MAX_LENGTH_LONG ? 0 : end - Base32.MAX_LENGTH_LONG; i < end; i++) {
			value = value << 5;
			tmp = Base32.decodeChar(str.charAt(i));
			value |= tmp;
		}
		return value;
	}

	/**
	 * 解码到基础值。
	 * 
	 * @param str
	 *            字符值。
	 * @param begin
	 *            开始位置，包含。
	 * @param end
	 *            结束位置，不包含。
	 * @return
	 */
	public static final long decodeBase32ToLong(String str, int begin, int end) {
		long value = 0L;
		int tmp = 0;
		for (int i = end - begin < Base32.MAX_LENGTH_LONG ? begin : end - Base32.MAX_LENGTH_LONG; i < end; i++) {
			value = value << 5;
			tmp = Base32.decodeChar(str.charAt(i));
			value |= tmp;
		}
		return value;
	}

	/**
	 * 解码Base32文本数据到二进制数据。
	 * 
	 * @param data
	 *            文本数据。
	 * @return 解码数据。null 文本数据格式错误。
	 * @throws NullPointerException
	 *             null == data 时，抛出该异常。
	 */
	public static final byte[] decodeBase32ToBytes(String data) throws NullPointerException {
		int length = data.length();
		if (0 == length) {
			return null;
		}
		int length_convert = length / 8 * 5;
		switch (length % 8) {
		case 0:
			break; // switch (length % 8) {
		case 2:
			length_convert += 1;
			break; // switch (length % 8) {
		case 4:
			length_convert += 2;
			break; // switch (length % 8) {
		case 5:
			length_convert += 3;
			break; // switch (length % 8) {
		case 7:
			length_convert += 4;
			break; // switch (length % 8) {
		default:
			return null;
		}
		byte[] buff = new byte[length_convert];
		if (0 == Base32.decodeBase32ToBytes(data, buff, 0)) {
			return null;
		}
		return buff;
	}

	/**
	 * 解码Base32文本数据到二进制数据。
	 * 
	 * @param data
	 *            文本数据。
	 * @param buff
	 *            输出缓存。
	 * @param offset_buff
	 *            输出偏移量。
	 * @return 解码数据长度。 0 文本格式数据错误。
	 * @throws NullPointerException
	 *             null == data 时，抛出该异常。
	 * @throws IndexOutOfBoundsException
	 *             offset_buff < 0 || offset_buff + length_convert > buff.length 时, 抛出该异常。
	 */
	public static final int decodeBase32ToBytes(String data, byte[] buff, int offset_buff) throws NullPointerException, IndexOutOfBoundsException {
		int length = data.length(), div = length / 8, mod = length % 8, poi_data = 0, poi_buff = offset_buff;
		int value = 0, c = 0;
		Integer index = null;
		HashMap<Integer, Integer> hash_all = Base32.HASH_BASE32;
		for (int i = 0; i < div; i++) {
			value = 0;
			// char 1
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value = index.intValue();
			value <<= 3;
			// char 2
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 2;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x03) << 6;
			// char 3
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() << 1;
			// char 4
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 4;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x0F) << 4;
			// char 5
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 1;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x01) << 7;
			// char 6
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() << 2;
			// char 7
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 3;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x07) << 5;
			// char 8
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue();
			buff[poi_buff++] = (byte) value;
		}
		HashMap<Integer, Integer> hash = null;
		switch (mod) {
		case 0:
			break; // switch (mod) {
		case 2:
			hash = Base32.HASH_BASE32_MOD2;
			// char 1
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value = index.intValue();
			value <<= 3;
			// char 2
			c = data.charAt(poi_data++);
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 2;
			buff[poi_buff++] = (byte) value;
			break; // switch (mod) {
		case 4:
			hash = Base32.HASH_BASE32_MOD4;
			// char 1
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value = index.intValue();
			value <<= 3;
			// char 2
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 2;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x03) << 6;
			// char 3
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() << 1;
			// char 4
			c = data.charAt(poi_data++);
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 4;
			buff[poi_buff++] = (byte) value;
			break; // switch (mod) {
		case 5:
			hash = Base32.HASH_BASE32_MOD5;
			// char 1
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value = index.intValue();
			value <<= 3;
			// char 2
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 2;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x03) << 6;
			// char 3
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() << 1;
			// char 4
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 4;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x0F) << 4;
			// char 5
			c = data.charAt(poi_data++);
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 1;
			buff[poi_buff++] = (byte) value;
			break; // switch (mod) {
		case 7:
			hash = Base32.HASH_BASE32_MOD7;
			// char 1
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value = index.intValue();
			value <<= 3;
			// char 2
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 2;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x03) << 6;
			// char 3
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() << 1;
			// char 4
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 4;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x0F) << 4;
			// char 5
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 1;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x01) << 7;
			// char 6
			c = data.charAt(poi_data++);
			index = hash_all.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() << 2;
			// char 7
			c = data.charAt(poi_data++);
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 3;
			buff[poi_buff++] = (byte) value;
			break; // switch (mod) {
		default:
			return 0;
		}
		return poi_buff - offset_buff;
	}

	/**
	 * 解码Base32文本数据到二进制数据。
	 * 
	 * @param data
	 *            文本数据。
	 * @param offset_data
	 *            文本数据偏移量。
	 * @param length_data
	 *            文本数据长度。
	 * @return 解码数据。null 文本数据格式错误。
	 * @throws NullPointerException
	 *             null == data 时，抛出该异常。
	 * @throws IndexOutOfBoundsException
	 *             offset_data < 0 || length_data < 0 || offset_data + length_data > data.length 时, 抛出该异常。
	 */
	public static final byte[] decodeBase32ToBytes(byte[] data, int offset_data, int length_data) throws NullPointerException, IndexOutOfBoundsException {
		if (0 == length_data) {
			return null;
		}
		int length_convert = length_data / 8 * 5;
		switch (length_data % 8) {
		case 0:
			break; // switch (length % 8) {
		case 2:
			length_convert += 1;
			break; // switch (length % 8) {
		case 4:
			length_convert += 2;
			break; // switch (length % 8) {
		case 5:
			length_convert += 3;
			break; // switch (length % 8) {
		case 7:
			length_convert += 4;
			break; // switch (length % 8) {
		default:
			return null;
		}
		byte[] buff = new byte[length_convert];
		if (0 == Base32.decodeBase32ToBytes(data, offset_data, length_data, buff, 0)) {
			return null;
		}
		return buff;
	}

	/**
	 * 解码Base32文本数据到二进制数据。
	 * 
	 * @param data
	 *            文本数据。
	 * @param offset_data
	 *            文本数据偏移量。
	 * @param length_data
	 *            文本数据长度。
	 * @param buff
	 *            输出缓存。
	 * @param offset_buff
	 *            输出偏移量。
	 * @return 解码数据长度。 0 文本格式数据错误。
	 * @throws NullPointerException
	 *             null == data || null == buff 时，抛出该异常。
	 * @throws IndexOutOfBoundsException
	 *             offset_data < 0 || length_data < 0 || offset_data + length_data > data.length || offset_buff < 0 || offset_buff + length_convert > buff.length 时, 抛出该异常。
	 */
	public static final int decodeBase32ToBytes(byte[] data, int offset_data, int length_data, byte[] buff, int offset_buff)
	        throws NullPointerException, IndexOutOfBoundsException {
		int length = length_data, div = length / 8, mod = length % 8, poi_data = offset_data, poi_buff = offset_buff;
		int value = 0, c = 0;
		Integer index = null;
		HashMap<Integer, Integer> hash = Base32.HASH_BASE32;
		for (int i = 0; i < div; i++) {
			value = 0;
			// char 1
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value = index.intValue();
			value <<= 3;
			// char 2
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 2;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x03) << 6;
			// char 3
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() << 1;
			// char 4
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 4;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x0F) << 4;
			// char 5
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 1;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x01) << 7;
			// char 6
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() << 2;
			// char 7
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 3;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x07) << 5;
			// char 8
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue();
			buff[poi_buff++] = (byte) value;
		}
		switch (mod) {
		case 0:
			break; // switch (mod) {
		case 2:
			hash = Base32.HASH_BASE32_MOD2;
			// char 1
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value = index.intValue();
			value <<= 3;
			// char 2
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 2;
			buff[poi_buff++] = (byte) value;
			break; // switch (mod) {
		case 4:
			hash = Base32.HASH_BASE32_MOD4;
			// char 1
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value = index.intValue();
			value <<= 3;
			// char 2
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 2;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x03) << 6;
			// char 3
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() << 1;
			// char 4
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 4;
			buff[poi_buff++] = (byte) value;
			break; // switch (mod) {
		case 5:
			hash = Base32.HASH_BASE32_MOD5;
			// char 1
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value = index.intValue();
			value <<= 3;
			// char 2
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 2;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x03) << 6;
			// char 3
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() << 1;
			// char 4
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 4;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x0F) << 4;
			// char 5
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 1;
			buff[poi_buff++] = (byte) value;
			break; // switch (mod) {
		case 7:
			hash = Base32.HASH_BASE32_MOD7;
			// char 1
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value = index.intValue();
			value <<= 3;
			// char 2
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 2;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x03) << 6;
			// char 3
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() << 1;
			// char 4
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 4;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x0F) << 4;
			// char 5
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 1;
			buff[poi_buff++] = (byte) value;
			value = (index.intValue() & 0x01) << 7;
			// char 6
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() << 2;
			// char 7
			c = 0xFF & data[poi_data++];
			index = hash.get(c);
			if (null == index) {
				return 0;
			}
			value |= index.intValue() >> 3;
			buff[poi_buff++] = (byte) value;
			break; // switch (mod) {
		default:
			return 0;
		}
		return poi_buff - offset_buff;
	}
}
