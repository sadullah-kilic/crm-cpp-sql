BÜTÜN İSİMLER ADMIN
ŞİFRELER 1234 
SQL DE HOST DAHİL 

EĞER BAĞLANTI KURULMUYORSA AŞIDAKİ İŞLEMLERİ UYGULAYIN 




1. MySQL Connector/C++ Kütüphanesini Ayarla  
   - Daha önce indirdiğin MySQL Connector/C++ zip dosyasını açtığını varsayıyorum.  
   - İçindeki include klasörünü ve lib klasörünü bir yere not et (örneğin masaüstünde).

2. Visual Studio Code'da Derleme İçin Ayar  
   - Derlemek için terminal açmalısın (VS Code’da: Ctrl + ` (backtick) veya Menü > Terminal > New Terminal)  
   - MySQL Connector kütüphanesini derleme komutuna eklemen lazım.

3. Derleme Komutu Örneği (Windows için)  
   Terminalde şu şekilde derleyebilirsin (yolları kendi sistemine göre değiştir):

bash
g++ crm.cpp -o crm.exe -I"C:/Users/musta/Desktop/mysql-connector-c++-x.x.x/include" -L"C:/Users/musta/Desktop/mysql-connector-c++-x.x.x/lib" -lmysqlcppconn


- -I : Başlık dosyalarının yolu (include)  
- -L : Kütüphane dosyalarının yolu (lib)  
- -lmysqlcppconn : Kütüphaneyi bağla  

4. Programı Çalıştırmak  
Derleme başarılı olursa, terminalde:

bash
./crm.exe


veya Windows için

bash
crm.exe


yazarak programı çalıştırabilirsin.

---

ÖNEMLİ:  
MySQL Server’ın çalışıyor olması ve bağlantı bilgilerinin (host, kullanıcı, şifre, db adı) doğru olması lazım.
