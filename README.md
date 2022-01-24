# SFSymbolsSwiftFileGenerator

You can change all symbol names of SF Symbols into enum cases on the swift file.

## Demo
![SFSymbolsSwiftFileGenerator-640](https://user-images.githubusercontent.com/67716751/150810806-5ce41967-423f-425c-80d1-798eff5a0641.gif)

## HowToUse

1. Copy all symbol names from SF Symbols you want to use.(This project includes it of SF Symbols v3.2) 
<img width="500" alt="select-all-symbols" src="https://user-images.githubusercontent.com/67716751/150798946-c8b9e231-a113-46b4-b579-0a52e822ce01.png">

2. paste it on SFSymbols.txt on this project.
<img width="500" alt="paste-sf-symbols" src="https://user-images.githubusercontent.com/67716751/150799146-40e5e41c-4f01-47a2-958e-5d8cdb501d35.png">

3. Build with iOS sumilator with your app lower target version.
<img width="500" alt="build-ios13" src="https://user-images.githubusercontent.com/67716751/150799785-f8d010c1-d4e1-4038-99d6-a56cb0067fba.png">

4. if generating is successed, the path of SFSymbols.swift appears on debug console.

for example

```
Success to write:
open /Users/littleossa/Library/Developer/CoreSimulator/Devices/C9AB419E-4236-5772-B856-83A0E8A2F3F5/data/Containers/Data/Application/0162D80D-6B69-9E1E-4F2E-51E6811C95D1/Documents/
```

5. copy and paste it on your terminal then enter it.

6. these is the enum cases of SF Symbols on a swift file.
<img width="500" alt="sfsymbol-enum" src="https://user-images.githubusercontent.com/67716751/150803096-7838f61b-3059-4bce-b7ab-854c462d2339.png">

7. Use them as you like and enjoy!

### Why this file imports UIKit?

SFSymbol.swift includes UIImage+Extension to use right away.

<img width="500" alt="uiimafe-extension" src="https://user-images.githubusercontent.com/67716751/150804593-9ae998a9-c32f-419f-93ae-644d89e7ce22.png">
