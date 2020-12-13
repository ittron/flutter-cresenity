


import 'dart:convert';

import 'package:flutter_cresenity/helper/str.dart';
import 'package:flutter_cresenity/interface/arrayable.dart';

import '../helper/arr.dart';
import 'array.dart';
import 'collection.dart';


class MessageBag {

  ///All of the registered messages.
  Collection<Array<String>> _messages = Collection();

  ///Default format for message output.
  String _format = ':message';

  MessageBag([Collection messages]) {
    if(messages==null) {
      messages = Collection();
    }
    messages.forEach((key, value) {
      this._messages[key] = Arr.wrap(value);
    });

  }

  ///Get the keys present in the message bag.
  Array keys() {
    return Array(_messages.keys);
  }


  ///Add a message to the message bag.
  MessageBag add(key, message){
    if (this._isUnique(key, message)) {
      if(this._messages[key]==null) {
        this._messages[key] = Array();

      }
      this._messages[key].add(message);

    }

    return this;
  }

  ///Determine if a key and message combination already exists.
  bool _isUnique(String key, String message) {
    return !_messages.containsKey(key) || ! _messages[key].contains(message);
  }

  ///Merge a new array of messages into the message bag.
  MessageBag merge(Collection<Array> messages) {
    this._messages.merge(messages);
    return this;
  }

  /// Determine if messages exist for all of the given keys.
  bool has(String key) {
    if (isEmpty()) {
      return false;
    }

    if (key==null) {
      return any();
    }

    Array keys = Arr.wrap(key);
    for(int i=0;i<keys.length;i++) {
      if(first(keys[i]) == '') {
        return false;
      }
    }
    return true;
  }


  ///Get the number of messages in the message bag.
  int count() {
    int count = 0;
    _messages.forEach((key, value) {
      count+=value.length;
    });
    return count;
  }

  ///Determine if the message bag has any messages.
  bool any() {
    return count()>0;
  }

  ///Get the number of messages in the message bag.
  bool isEmpty() {
    return !any();
  }


  ///Get the first message from the message bag for a given key.
  String first([String key,String format]) {
    Array messages = key == null ? all(format) : get(key,format);
    String firstMessage = Arr.first(messages, null, '');
    return firstMessage;
  }

  ///Get the raw messages in the message bag.
  Collection messages() {
    return this._messages;
  }

  ///Get the raw messages in the message bag.
  Collection getMessages() {
    return this.messages();
  }

  MessageBag getMessageBag() {
    return this;
  }


    ///Get the appropriate format based on the given format.
  String _checkFormat(String format) {
    return format ?? this._format;
  }

  ///Get all of the messages for every key in the message bag.
  Array all([String format]) {
    format = _checkFormat(format);
    Array all = Array();

    _messages.forEach((key, value) {
      all.merge(_transform(value,format,key));
    });

    return all;
  }

  ///Format an array of messages.
  Array _transform(Array messages, String format, String messageKey) {
    return messages.map((message) => Str.replace([':message', ':key'], [message, messageKey], format));

  }
  ///Get all of the unique messages for every key in the message bag.
  Array unique([String format]) {
    return Arr.unique(all(format));
  }


  Array get(String key, [String format]) {
    if(_messages.containsKey(key)) {
      return _transform(_messages[key], _checkFormat(format), key);
    }

    if(Str.contains(key,'*')) {
      return this._getMessagesForWildcardKey(key,format);
    }
    return Array();
  }

  Array _getMessagesForWildcardKey(String key,[String format]) {
    Collection filtered =  _messages.filter((String messageKey, Array value) {
      return Str.match(key, value);
    }).map((messageKey,messages) {
      return MapEntry(key,_transform(messages, _checkFormat(format), messageKey));
    });

    Array result = Array();
    filtered.forEach((key, value) {
      result.merge(value);
    });
    return result;


  }

  Map<String,dynamic> toJson() {
    return this._messages.all();
  }

  toString() {
    return jsonEncode(this.toJson());
  }
}