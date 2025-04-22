# Story Writer Application

Fellyla Fiorenza Wilianto 
5025221110

For the ETS Mobile Programming course, I created a simple application called "Story Writer" in Android Studio. Inspired by an application that I often use, this application has the benefit of being a place for ideas or a story writer whose results will be stored in a database. For the database itself, in this project I use the **sqflite database**. In this application, there are basic features such as creating stories, editing stories, viewing stories, and deleting stories.

## Getting Started

First, since we used sqflite, we must download the package first in our flutter project :
1. Download the sqflite by write ```flutter pub add sqflite``` in the terminal
2. Next, download the sqflite by write ``` flutter pub add path```
3. Make sure the sqflite and path are downloaded by checking pusbec.yaml

# Result
1. Homepage
   
   ![image](https://github.com/user-attachments/assets/8d4c11cb-9d9f-42fb-9493-30c48adb9a2f)
   
3. AppBar
   
   ![image](https://github.com/user-attachments/assets/9d9ecc97-99ef-438e-9d39-1f9ebbbda0a6)


4. Add New Story Feature

   ![image](https://github.com/user-attachments/assets/dd01b873-6899-41dc-be87-9e8444b68b04)

5. Edit Story Feature

   ![image](https://github.com/user-attachments/assets/90aaece7-ef9a-4564-9765-04e2b85d88ba)

7. Read Detail Feature

   ![image](https://github.com/user-attachments/assets/e41fdb6c-89d4-4e4b-a8d2-c324487c33e6)

9. Delete Feature

    I will deleting "Misteri Hiu Berkaki" story.

    ![image](https://github.com/user-attachments/assets/5374d323-c21d-458f-9396-95f9904ef95e)

# Program Structure

The structure for my "StoryWriter" application will be like this :

![image](https://github.com/user-attachments/assets/28ec9ada-5d83-4789-b339-cbf34f334323)

# How to Make the Program
1. First, we have to make the ```story_model.dart``` for the story models in models folder.
2. Then, we made the database seed for database as ```dp_helper.dart``` in database folder.
3. Then, adding the features in pages folder such as ```story_list_page.dart``` , ```story_form_page.dart``` , ```story_detail_page.dart``` .
4. Lastly, we modify the ```main.dart```as our homepage header.


# Problem Occurs

While working on this project, there were several problems that I encountered and these is the solutions that I found for this problems :
1. - Problem : DatabaseFactory not initialized when using sqflite in flutter. When using sqflite_common_ffi You must call databaseFactory = databaseFactoryFfi; before using global openDatabase API .
   - Solution : I search the solutions from stackoverflow page, this is the success solution https://stackoverflow.com/questions/76158800/databasefactory-not-initialized-when-using-sqflite-in-flutter
2. - Problem : ndk not the newest version
   - Solution : I don't do anything. It said error, but the program still works.
     
