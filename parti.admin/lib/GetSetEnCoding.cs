using System;
using System.Security.Cryptography;

namespace parti.admin.lib
{
    public class GetSetEnCoding
    {
        const string passphrase = "ສະຖາບັນຄົ້ນຄວ້າວິທະຍາສາດການປົກຄອງ ແລະ ຝຶກອົບຮົມ,​ ກະຊວງພາຍໃນ";
        byte[] DeResults;
        byte[] EnResults;

        public string SetEncryptData(string Message)
        {
            try
            {
                System.Text.UTF8Encoding UTF8 = new System.Text.UTF8Encoding();
                MD5CryptoServiceProvider HashProvider = new MD5CryptoServiceProvider();
                byte[] TDESKey;
                TripleDESCryptoServiceProvider TDESAlgorithm = new TripleDESCryptoServiceProvider();
                byte[] DataToEncrypt;
                ICryptoTransform Encryptor;

                TDESKey = HashProvider.ComputeHash(UTF8.GetBytes(passphrase));//convert private key to HASH code MD5
                TDESAlgorithm.Key = TDESKey;
                TDESAlgorithm.Mode = CipherMode.ECB;//encry mode ECB
                TDESAlgorithm.Padding = PaddingMode.PKCS7;//packed it to PKCS7
                DataToEncrypt = UTF8.GetBytes(Message);//convert param string to Bytes

                try
                {
                    Encryptor = TDESAlgorithm.CreateEncryptor();//send private key
                    EnResults = Encryptor.TransformFinalBlock(DataToEncrypt, 0, DataToEncrypt.Length);//merge param & private key   
                }       
                catch (Exception)
                {            
                    TDESAlgorithm.Clear();           
                    HashProvider.Clear();
                }
                return Convert.ToBase64String(EnResults);//convet it by Base64
            }   
            catch (Exception)     
            {          
                return "F";   
            }
        }

        public string GetDecryptData(string Message)
        {
            try
            {
                System.Text.UTF8Encoding UTF8 = new System.Text.UTF8Encoding();
                MD5CryptoServiceProvider HashProvider = new MD5CryptoServiceProvider();
                byte[] TDESKey;
                TripleDESCryptoServiceProvider TDESAlgorithm = new TripleDESCryptoServiceProvider();
                byte[] DataToDecrypt;
                ICryptoTransform Decryptor;

                TDESKey = HashProvider.ComputeHash(UTF8.GetBytes(passphrase));
                TDESAlgorithm.Key = TDESKey;
                TDESAlgorithm.Mode = CipherMode.ECB;
                TDESAlgorithm.Padding = PaddingMode.PKCS7;
                DataToDecrypt = Convert.FromBase64String(Message);

                try
                {
                    Decryptor = TDESAlgorithm.CreateDecryptor();
                    DeResults = null;
                    DeResults = Decryptor.TransformFinalBlock(DataToDecrypt, 0, DataToDecrypt.Length);
                }
                catch (Exception)
                {
                    TDESAlgorithm.Clear();
                    HashProvider.Clear();
                }
                return UTF8.GetString(DeResults);
            }
            catch (Exception)
            {
                return "F";
            }
        }
	}
}
