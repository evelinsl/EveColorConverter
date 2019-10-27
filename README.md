# EveColorConverter  

This scripts lets you convert between HEX and RGB color formats, right from your nearby chat.

The script watches a certain channel for input and if it sees something to convert, it will reply.

## Usage

Rez an object with this script. You can alter the listing channel by modifying the `listenChannel` integer at the top of the script.

## How to use

Send a HEX or RGB value to the chosen channel. For example, if `listenChannel` is `616`, you can try to send the following commands:

### RGB to HEX:
```
Send:  /616 12 12 12
Reply: RGB Value (12 12 12) converted to hex: #0C0C0C
```

Seperate the RGB values with a character defined in `rgbSeperator`. You can change this value from the chat by sending a letter to the script:

```
Send:  /616 |
Reply: The RGB seperator has been changed to '|'
```

### HEX to RGB:
```
Send:  /616 20461B
Reply: HEX Value (#20461B) converted to RGB: 32 70 27
```

You can send HEX values with or without the sharp sign (#).

## License

- You are free to use and modify this script for personal usage.
- You are NOT allowed to sell items with this script in it.
- You are NOT allowed to sell this script.


---


❤ Made by evelin
