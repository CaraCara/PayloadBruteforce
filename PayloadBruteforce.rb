require 'openssl'
require 'digest/sha2'
# This encryption/decryption routine is borrowed from someplace online, I will annotate where later, but the basis of the encryption/decryption is typical openssl useage in Ruby from what I can gather.
payload = "puts 'Plans for Blofelds newest Doomsday Device. This is top secret!'"# 99,9% of the text is in tact a stray " ' " was causing me issue, so I removed it, and the puts is obviously for testing execution. This was left in tact to aid in verifying where the encryption/decryption routine was from.
sha256 = Digest::SHA2.new(256)
aes = OpenSSL::Cipher.new("AES-256-CFB")
key = sha256.digest("15") #Set this to be something simple and so it could overshoot to prove it was not just sequential.
#IV Was left out as this is just to prove the feasability. In actuality it could be randomized as much as wanted.
aes.encrypt
aes.key = key

encrypted_data = aes.update(payload) + aes.final

begin
x = rand(1..20).to_s #Will search randomly every iteration for a number between 1-20. Note: This HAS to be passed as a string to the Hasher apparently.
puts x #Showing off so you can see some hilarity and check how many loops it went through and prove it hops around.
aes.decrypt
aes.key = key = sha256.digest(x)
tester = aes.update(encrypted_data) + aes.final
puts tester #Prints out the 'decrypted' string so we can see what each value puts to.
eval(tester) #This is very crucial, it attempts to execute the 'decrypted' string. Proving it can be done. While this is simply a 'put' you could do a lot more, and even execute C/Java/ASM code from this point, and verify it's executeable by paresing the main line and executing that, or however you wish.
rescue Exception #Exception handling because most won't evaluate true.
   retry #Sends back to top of loop.
end
