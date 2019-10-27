///
/// Evelins Color Converter
/// Copyright by ofcourse Evelin ;)
///
/// Check out the Github page for documentation:
/// https://github.com/evelinsl/EveColorConverter
///  

integer listenChannel = 616;
string rgbSeperator = " ";

///
/// Tries to convert the given input to an RGB string
///
integer tryHexToRGB(string input)
{
    if(llGetSubString(input, 0, 0) == "#")
        input = llGetSubString(input, 1, 6);
        
    if(llStringLength(input) != 6)
        return FALSE; 
    
    string rgbString = 
          (string)hexToNumber(llGetSubString(input, 0, 1)) 
        + rgbSeperator
        + (string)hexToNumber(llGetSubString(input, 2, 3))
        + rgbSeperator
        + (string)hexToNumber(llGetSubString(input, 4, 5));
    
    llSay(0, "HEX Value (#" + input + ") converted to RGB: " + rgbString);
    
    return TRUE;
}


///
/// Converts a hexidecimal string to an integer
///
integer hexToNumber(string hex)
{
    integer result = 0;
    integer length = llStringLength(hex);
    integer index = length - 1;
    string chars = "ABCDEF";
    
    hex = llToUpper(hex);
    
    for(; index >= 0; index--)
    {
        string char = llGetSubString(hex, index, index);
        integer decimal;
        
        // Lets check if its an number or not
        
        if((string)((integer)char) == char)
            decimal = (integer)char;
        else {
            decimal = llSubStringIndex(chars, char);
            if(decimal == -1)
            {
                llSay(0, "Could not parse hexidecimal number '" + hex + "', result may be invalid.");
                return 0;
            }
            
            decimal += 10;
        }
        
        result += decimal * (integer)llPow(16, length - index - 1);
    }
    
    return result;
}


///
/// Tries to convert the given input to hexidecimal string
///
integer tryRGBToHex(string input)
{
    list tokens = llParseString2List(input, [rgbSeperator], []);
    if(llGetListLength(tokens) != 3)
        return FALSE;
        
    string   result = numberToHex((integer)llList2String(tokens, 0));
    result = result + numberToHex((integer)llList2String(tokens, 1));
    result = result + numberToHex((integer)llList2String(tokens, 2));

    llSay(0, "RGB Value (" + input + ") converted to hex: #" + result);
    
    return TRUE;
}


///
/// Adds some "0"'s in front of the number of the length is less than "length"
///     
string prefixNumber(string numberString, integer length)
{
    integer add = length - llStringLength(numberString);
    
    if(add > 0)
    {
        integer index;
        
        for(index = add; index >= 1; index--)
            numberString = "0" + numberString;
    } 
    
    return numberString;    
}


///
/// Converts the given number into a hexidecimal string
/// 
string numberToHex(integer number)
{
    string chars = "0123456789ABCDEF";
    string result = "";
    
    do
    {
        result = llGetSubString(chars, number & 0xF, number & 0xF) + result;
      
    } while((number = (number >> 4) & 0xfffFFFF) > 0);
     
    return prefixNumber(result, 2); 
} 


default
{
    
    state_entry()
    {
        llListen(listenChannel, "", "", "");
    }
    

    listen(integer channel, string name, key id, string message)
    {   
        if(listenChannel != channel)
            return;
        
        if(llStringLength(message) == 1)
        {
            rgbSeperator = message;
            llSay(0, "The RGB seperator has been changed to '" + rgbSeperator + "'");
            return;
        }
        
        if(!tryHexToRGB(message) && !tryRGBToHex(message))
            llSay(0, "Sorry, thats input i don't understand...");
    }
}
