# Prepare for releasing artifacts

## 1) Create a master password for your maven environment. 
This must be done only once for each development/build machine.

    $> mvn --encrypt-master-password

   This command will produce an encrypted version of the password, something like:
   
     {jSMOWnoPFgsHVpMvz5VrIt5kRbzGpI8u+9EF1iFQyJQ=}
     
     
   Store this password in the **${user.home}/.m2/settings-security.xml**; it should looks like:
   
           <settingsSecurity>
              <master>{jSMOWnoPFgsHVpMvz5VrIt5kRbzGpI8u+9EF1iFQyJQ=}</master>
           </settingsSecurity>

   [see details about maven encryption here](https://maven.apache.org/guides/mini/guide-encryption.html)

## 2) Open the file ~/.m2/settings.xml in an editor

## 3) Set up the GPG signer

 3.1 - create the gpg key with the following command and write down the passphrase used:

    $> gpg2 --gen-key
    
   This will generate a new key pair on your machine. You can list it using:
   
    $. gpg2 --list-keys
    
    - write down the key ID (you will use it in the next step). 

 3.1.1 - Encript the passphrase used to create the GPG key in step 3.1 and write down \
 the resulted string. 
 It will be used into the <gpg.passphrase> property tag in the profile on step 3.3.
 
     $> mvn --encrypt-password
  
   or
         
     $> mvn -ep    
    
 3.2 - Share your public key to the world
 
     $> gpg2 --keyserver hkp://pool.sks-keyservers.net --send-keys <public keyID>

[see GPG reference doc](http://central.sonatype.org/pages/working-with-pgp-signatures.html "reference")

 3.3 - insert a new profile in the opened _setting.xml_ file as the one below. 
 Note that you identify which GPG tool is installed on your machine and set the executable properly.
 
      <profile>
            <id>GPG-signer</id>
            <activation>
                <property>
                    <name>c8tech.build.release</name>
                </property>
            </activation>
            <properties>
                <gpg.keyname>[the key id from step 3.1]</gpg.keyname>
                <gpg.executable>gpg2</gpg.executable>
                <gpg.passphrase>[the encrypted passphrase from step 3.1.1]<gpg.passphrase>
            </properties>
      </profile>
      
 3.3.1 - insert a server tag in the settings.xml
 
     <server>
            <id>[key from step 3.1]</id>
            <passphrase>[the value from 3.4]</passphrase>
        </server>     
      


## 4) Set the Jar Signer

 3.1 - create the keystore in the command line. (passwords will be asked for the store and key)

    $> keytool -genkey -keystore <keys-name>.p12 -alias <keys-alias> -storetype PKCS12
    
       - write down the passwords used since you will need them later.


 3.2 - Encript both _storepass_ and _keypass_ passwords used in the step 3.1.
    
    $> mvn -ep
    $> Password: <keypass>  

       - copy the resulted string to the <jarsigner.keypass> tag in the profile in 3.3
     
    $> mvn -ep 
    $> Password: <storepass>

       - copy the resulted string to the <jarsigner.storepass> tag in the profile in 3.3

 3.3 - insert a new profile in the opened setting.xml file.

     <profile>
        <id>jar-signer</id>
        <activation>
            <property>
                <name>c8tech.build.release</name>
            </property>
        </activation>
        <properties>
            <jarsigner.alias>c8tech-keys</jarsigner.alias>
            <jarsigner.keystore>${c8tech.workspace.dir}/keys/<keys-name>.p12</jarsigner.keystore>
                <jarsigner.keypass>{put the pwd encripted here}</jarsigner.keypass>
                <jarsigner.storepass>{put the pwd encripted here}</jarsigner.storepass>
                <jarsigner.storetype>pkcs12</jarsigner.storetype>
                <jarsigner.tsa>https://timestamp.geotrust.com/tsa</jarsigner.tsa>
            </properties>
        </profile>


 3.4 - save the file ~/.m2/settings.xml.
