import React, {useState} from 'react';
import {View, TextInput, StyleSheet} from 'react-native';

import {setSharedData} from './utils';

const App = () => {
  const [text, setText] = useState('');
  const widgetData = {
    sharedText: text,
  };

  const handleSubmit = async () => {
    try {
      // iOS
      await setSharedData(widgetData);
    } catch (error) {
      console.log({error});
    }
  };

  return (
    <View style={styles.container}>
      <TextInput
        style={styles.input}
        onChangeText={newText => setText(newText)}
        value={text}
        returnKeyType="send"
        onEndEditing={handleSubmit}
        placeholder="Add data you want to share"
      />
    </View>
  );
};

export default App;

const styles = StyleSheet.create({
  container: {
    marginTop: '50%',
    paddingHorizontal: 24,
  },
  input: {
    width: '100%',
    borderBottomWidth: 1,
    fontSize: 20,
    minHeight: 40,
  },
});
