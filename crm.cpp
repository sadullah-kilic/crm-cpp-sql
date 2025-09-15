#include <iostream>
#include <mysql/jdbc.h> // MySQL Connector/C++ başlığı
using namespace std;

int main() {
    try {
        // MySQL bağlantısı
        sql::mysql::MySQL_Driver* driver;
        sql::Connection* con;
        sql::Statement* stmt;
        sql::ResultSet* res;

        driver = sql::mysql::get_mysql_driver_instance();
        con = driver->connect("tcp://127.0.0.1:3306", "root", "sifren"); // Şifreyi değiştir

        con->setSchema("crm"); // Veritabanı adın

        stmt = con->createStatement();

        int secim;
        cout << "1- Musteri Ekle\n2- Listele\n3- Sil\nSeciminiz: ";
        cin >> secim;

        if (secim == 1) {
            string ad, soyad, email;
            cout << "Ad: "; cin >> ad;
            cout << "Soyad: "; cin >> soyad;
            cout << "Email: "; cin >> email;
            string query = "INSERT INTO musteriler (ad, soyad, email) VALUES ('" + ad + "', '" + soyad + "', '" + email + "')";
            stmt->execute(query);
            cout << "Musteri eklendi.\n";

        } else if (secim == 2) {
            res = stmt->executeQuery("SELECT * FROM musteriler");
            while (res->next()) {
                cout << res->getInt("id") << " - " << res->getString("ad") << " " << res->getString("soyad") << " | " << res->getString("email") << endl;
            }

        } else if (secim == 3) {
            int id;
            cout << "Silinecek musteri ID: ";
            cin >> id;
            stmt->execute("DELETE FROM musteriler WHERE id = " + to_string(id));
            cout << "Silindi.\n";
        }

        delete res;
        delete stmt;
        delete con;

    } catch (sql::SQLException& e) {
        cerr << "Hata: " << e.what() << endl;
    }

    return 0;
}


---

📌 Gerekli SQL Tablosu:

sql
CREATE DATABASE crm;

USE crm;

CREATE TABLE musteriler (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ad VARCHAR(50),
    soyad VARCHAR(50),
    email VARCHAR(100)
);
