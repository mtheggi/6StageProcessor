#include <iostream>
#include <map>
#include <string>
#include <vector>
#include <cstring>
#include <algorithm>
using namespace std;

void CreatingHashingTableForRegisterMap(map<string, string> &mp)
{
    vector<string> RegAddress{"000", "001", "010", "011", "100", "101", "110", "111"};
    for (int i = 0; i < 8; i++)
    {
        string temp = to_string(i);
        mp["R" + temp] = RegAddress[i];
    }
};
void CreatingHashingTable(map<string, string> &mp)
{

    // according to Control signal Table
    vector<string> InstrutionsOpCodeAndFunc{"000000", "000001", "000010", "001000", "001100",
                                            "001101", "001011", "001110", "001111", "001001", "001010", "001110", "001011",
                                            "010001", "010010", "011011", "100011", "101000", "101001", "101100", "110000",
                                            "110001", "111100", "111101", "111111"};
    vector<string> InstrSet{
        "NOP", "SETC", "CLRC", "NOT", "INC", "DEC", "MOV", "ADD", "SUB", "AND", "OR",
        "IADD", "LDM", "OUT", "IN", "LDD", "STD", "JC", "JZ", "JMP", "PUSH", "POP", "CALL",
        "RET", "RTI"};

    for (int i = 0; i < 25; i++)
    {

        mp[InstrSet[i]] = InstrutionsOpCodeAndFunc[i];
    }
};
string GetInstrutionFromLine(string x, int &index)
{
    string temp;
    for (int i = 0; i < x.length(); i++)
    {
        if (x[i] != ' ' && x[i] != '\t')
        {
            temp.push_back(x[i]);
        }
        else
        {
            if (!temp.empty())
            {
                index = i;
                return temp;
            }
        }
    }
    index = x.length() - 1;
    return temp;
};
bool DetectType(string x)
{
    if (x == "IADD" || x == "LDM")
    {
        return true;
    }
    return false;
}
bool validString(string x)
{
    if (x.empty())
    {
        return false;
    }
    return true;
}
string InstrRegisters(string x)
{
    if (x == "NOP" || x == "SETC" || x == "CLRC" || x == "RET" || x == "RTI")
    {
        return "000";
    }
    else if (x == "NOT" || x == "INC" || x == "DEC" || x == "MOV" || x == "LDD")
    {
        return "101";
    }
    else if (x == "POP" || x == "IN")
    {
        return "001";
    }
    else if (x == "STD")
    {
        return "110";
    }
    else if (x == "PUSH" || x == "OUT" || x == "CALL" || x == "JZ" || x == "JC" || x == "JMP")
    {
        return "100";
    }
    else if (x == "ADD" || x == "OR" || x == "SUB" || x == "AND")
    {
        return "111";
    }
    return "xxx";
}
string GetCleanInstrutionsRegisters(string inst, string instr, int index)
{
    string temp;
    bool WaitComma = false;
    for (int i = index + 1; i < inst.length(); i++)
    {

        if (inst[i] != ' ' && inst[i] != '\t')
        {
            if (inst[i] != ',' && !WaitComma)
            {
                temp.push_back(inst[i]);
                if (temp.length() % 2 == 0 && temp[temp.length() - 2] == 'R' && temp[temp.length() - 1] >= '0' && temp[temp.length() - 1] <= '7' && i < inst.length() - 1)
                {
                    WaitComma = true;
                }
            }
            else
            {
                if (!WaitComma)
                    return "XXX";
                WaitComma = false;
            }
        }
        // else if (temp.length() % 2 != 0)
        // {
        //     return "XXX";
        // }
    }
    return temp;
}

string Get16bitCode(string inst, string instr, map<string, string> RegistersMap, map<string, string> DecodingMap, int is16or32bit, string WhichRegisterIsNeed, int index)
{
    string temp, rs = "000", rt = "000", rd = "000";

    temp += DecodingMap[instr];
    temp += to_string(is16or32bit);
    string Registers = GetCleanInstrutionsRegisters(inst, instr, index);
    if (WhichRegisterIsNeed == "101")
    {
        if (Registers.length() != 4)
        {
            return "XXX";
        }

        rs = RegistersMap[Registers.substr(2, 2)];
        rd = RegistersMap[Registers.substr(0, 2)];
        if (instr == "LDD" || instr == "MOV")
        {
            rt = rs;
            rs = "000";
        }
    }
    else if (WhichRegisterIsNeed == "001")
    {
        if (Registers.length() != 2)
        {
            return "XXX";
        }
        rd = RegistersMap[Registers.substr(0, 2)];
    }
    else if (WhichRegisterIsNeed == "100")
    {
        if (Registers.length() != 2)
        {
            return "XXX";
        }
        rs = RegistersMap[Registers.substr(0, 2)];
    }
    else if (WhichRegisterIsNeed == "110")
    {
        if (Registers.length() != 4)
        {
            return "XXX";
        }
        rs = RegistersMap[Registers.substr(2, 2)];
        rt = RegistersMap[Registers.substr(0, 2)];
    }
    else if (WhichRegisterIsNeed == "111")
    {
        if (Registers.length() != 6)
        {
            return "XXX";
        }
        rs = RegistersMap[Registers.substr(2, 2)];
        rd = RegistersMap[Registers.substr(0, 2)];
        rt = RegistersMap[Registers.substr(4, 2)];
    }
    else if (Registers.length() != 0)
    {
        return "XXX";
    }
    temp += rs;
    temp += rt;
    temp += rd;
    return temp;
}

string GetFirst16Bit(string inst, string instr, map<string, string> DecodingMap, map<string, string> RegistersMap, int is16or32bit, int index)
{
    string temp, rs = "000", rt = "000", rd = "000";

    temp += DecodingMap[instr];
    temp += to_string(is16or32bit);
    string RegistersPlusHexValue = GetCleanInstrutionsRegisters(inst, instr, index);
    if (instr == "LDM")
    {
        rd = RegistersMap[RegistersPlusHexValue.substr(0, 2)];
    }
    else if (instr == "IADD")
    {
        rs = RegistersMap[RegistersPlusHexValue.substr(2, 2)];
        rd = RegistersMap[RegistersPlusHexValue.substr(0, 2)];
        // rt=RegistersMap[RegistersPlusHexValue.substr(4,4)];
    }
    temp += rs;
    temp += rt;
    temp += rd;
    return temp;
}
string ConvertHexToBin(string hex)
{
    while (hex.size() < 4)
    {
        hex = '0' + hex;
    }
    string temp;
    for (int i = 0; i < 4; i++)
    {
        switch (toupper(hex[i]))
        {
        case '0':
            temp += "0000";
            break;
        case '1':
            temp += "0001";
            break;
        case '2':
            temp += "0010";
            break;
        case '3':
            temp += "0011";
            break;
        case '4':
            temp += "0100";
            break;
        case '5':
            temp += "0101";
            break;
        case '6':
            temp += "0110";
            break;
        case '7':
            temp += "0111";
            break;
        case '8':
            temp += "1000";
            break;
        case '9':
            temp += "1001";
            break;
        case 'A':
            temp += "1010";
            break;
        case 'B':
            temp += "1011";
            break;
        case 'C':
            temp += "1100";
            break;
        case 'D':
            temp += "1101";
            break;
        case 'E':
            temp += "1110";
            break;
        case 'F':
            temp += "1111";
            break;
        };
    }
    return temp;
}
int ConvertHexToDec(string hex) {
    int dec = 0;
    for (int i = 0; i <= hex.size() - 1; i++) {
        dec *= 16;
        dec += (hex[i] >= 'A') ? hex[i] - 'A' + 10 : hex[i] - '0';
    }
    return dec;
}
string GetSecond16Bit(string inst, string instr, int index)
{

    string temp;
    string RegistersPlusHexValue = GetCleanInstrutionsRegisters(inst, instr, index);
    if (instr == "LDM")
    {
        string hex = RegistersPlusHexValue.substr(2, 5);
        temp = ConvertHexToBin(hex);
    }
    else
    {
        string hex = RegistersPlusHexValue.substr(4, 7);
        temp = ConvertHexToBin(hex);
    }
    return temp;
}
void WriteConfig()
{
    cout << "// memory data file (do not edit the following line - required for mem load use)\n";
    cout << "// instance=/integration/f/ic/ram\n";
    cout << "// format=mti addressradix=d dataradix=s version=1.0 wordsperline=1" << endl;
};
int CheckOrg(string x, int index)
{
    string temp;
    bool Flag = false;
    int TempIndex = index;
    for (int i = TempIndex; i < x.length(); i++)
    {
        if (x[i] == ' ' && x[i] != '\t')
        {
            TempIndex++;
        }
        else
        {
            break;
        }
    }
    for (int i = TempIndex; i < x.length(); i++)
    {
        if (x[i] >= '0' && x[i] <= '9' || x[i] >= 'A' && x[i] <= 'F')
        {
            if (Flag)
                return -1;
            temp.push_back(x[i]);
        }
        else
        {
            Flag = true;
        }
    }
    int dec = ConvertHexToDec(temp);
    return dec;
}
void CheckComment(string &inst)
{
    int x = inst.find('#');
    if (x != -1)
    {
        inst = inst.substr(0, x);
    }
}
void CheckTab(string &inst)
{
    int x = inst.find('\t');
    if (x != -1)
    {
        inst = inst.substr(0, x);
    }
};
char * OpenFile()
{
    cout << "Please Enter The name Of File: ";
    string nameofFile, InputFile, OutputFile;
    cin >> nameofFile;
    InputFile = nameofFile + ".txt";
    const int len = InputFile.length();
    char *char_array = new char[len + 1];
    strcpy(char_array, InputFile.c_str());
    freopen(char_array, "r", stdin);
    OutputFile = nameofFile + ".mem";
    strcpy(char_array, OutputFile.c_str());
    return char_array;
};

int main()
{
 
    map<string, string> DecodingMap, RegistersMap;
    string inst;
    int length = 1, count = 2, WhereisError;
    bool NoErrorFlag = true;
    vector<pair<int, string>> Instructions;
    
    char* filename = OpenFile();
    CreatingHashingTable(DecodingMap);
    CreatingHashingTableForRegisterMap(RegistersMap);
   
    while (getline(cin, inst))
    {
        CheckComment(inst);
        CheckTab(inst);
        if (!inst.empty())
        {
            int index = 0;
            transform(inst.begin(), inst.end(), inst.begin(), ::toupper);
            string FullDecodedString;
            string instr = GetInstrutionFromLine(inst, index);
            if (instr == ".ORG")
            {
                int tempCount = CheckOrg(inst, index);
                if (tempCount == 0 || tempCount == 1)
                {
                    getline(cin, inst);
                    CheckTab(inst);
                    CheckComment(inst);
                    Instructions.push_back(make_pair(tempCount, ConvertHexToBin(inst)));
                    length += 2;
                    continue;
                }
                if (tempCount == -1)
                {
                    NoErrorFlag = false;
                    cout << "Error in Line number: " << length << endl;
                    break;
                }
                else
                {
                    length++;
                    count = tempCount;
                    continue;
                }
            }
            if (!validString(instr))
            {
                length++;
                continue;
            }
            bool IdentifiyType16Or32Bit = DetectType(instr); // 0 for 16 bit, 1 for 32 bit
            if (!IdentifiyType16Or32Bit)
            {
                string WhichRegisterIsNeed = InstrRegisters(instr); // RS RT RD
                string _16BitString = Get16bitCode(inst, instr, RegistersMap, DecodingMap, 0, WhichRegisterIsNeed, index);
                if (_16BitString.length() != 16)
                {
                    NoErrorFlag = false;
                    cout << "Error in Line number: " << length << endl;
                    break;
                }
                Instructions.push_back(make_pair(count++, _16BitString));
            }
            else
            {
                string First16Bit = GetFirst16Bit(inst, instr, DecodingMap, RegistersMap, 1, index);
                string Second16Bit = GetSecond16Bit(inst, instr, index);
                if (First16Bit.length() != 16 || Second16Bit.length() != 16)
                {
                    NoErrorFlag = false;
                    cout << "Error in Line number: " << length << endl;
                    break;
                }
                Instructions.push_back(make_pair(count++, First16Bit));
                Instructions.push_back(make_pair(count++, Second16Bit));
            }
        }
        length++;
    }
    if (NoErrorFlag)
        cout << "Success" << endl;
    freopen(filename, "w", stdout);
    if (NoErrorFlag)
    {

        WriteConfig();
        sort(Instructions.begin(), Instructions.end());
        for (auto it : Instructions)
        {
            cout << "   " << it.first << ": " << it.second << endl;
        }
    }
    else
    {
        cout << " THERE IS ERROR";
    }
}
