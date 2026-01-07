import 'dart:io';

void main() {
    File file = File('felszin_tpont.txt');
    List<Map<String, Object>> craters =  [];
    List<String> fileContent = file.readAsLinesSync();
    for(var line in fileContent) {
        List<String> data = line.trim().split('\t');
        craters.add({
            'x': double.tryParse(data[0])!,
            'y': double.tryParse(data[1])!,
            'r': double.tryParse(data[2])!,
            'nev': data[3]!,
        });
    }

    for(var line in craters){
        print(line.toString());
    }

    print("2. feladat:")
    print("Kráterek száma: ${craters.length}");

    
}