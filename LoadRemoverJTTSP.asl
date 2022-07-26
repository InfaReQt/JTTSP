state("JTTSP", "Epic Games")
{
    //Epic Games Version
    bool isLoading: "JTTSP.exe", 0x03AAF7F0, 0x8, 0x20, 0x148, 0x2A8, 0x80, 0x210, 0x1c0;

}

state("Towers-Win64-Shipping", "Steam")
{
    //Steam Version
    bool isLoading: "Towers-Win64-Shipping.exe", 0x3B317F0, 0x8, 0x128, 0x2A8, 0x50, 0x20, 0xC30, 0x1C0;
}

state("Towers-Win64-Shipping", "GOG 1.0.9")
{
    //GOG Version
    bool isLoading: "Towers-Win64-Shipping.exe", 0x03B967F0, 0x8, 0x128, 0xB90, 0x228, 0x16F8, 0xE0, 0x1688;
}

state("Towers-Win64-Shipping", "GOG 1.0.10")
{
    //GOG Version
    bool isLoading: "Towers-Win64-Shipping.exe", 0x03B967F0, 0x8, 0x128, 0xB48, 0xE0, 0xC30, 0x80, 0x1C0;
}

isLoading
{    
    return current.isLoading;
}


init{

    //Generate Hash for the game
    string MD5Hash;
    using (var md5 = System.Security.Cryptography.MD5.Create())
    using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
    MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
    print("Hash is: " + MD5Hash);

    //Set game verison according to hash
    switch (MD5Hash){
        case "2EDA192546747F75352571F507D729B5": version = "GOG 1.0.9"; break;
        case "D30428E963EFFC2255B8BDA13AA627D9": version = "GOG 1.0.10"; break;
        case "DE33449F9F6F60581B75FD78A0752456": version = "Steam"; break;
        case "1730FC7FACA5F1392B544CCC15A382D7": version = "Epic Games"; break;

default: version = "Unknown"; break;
}
}
