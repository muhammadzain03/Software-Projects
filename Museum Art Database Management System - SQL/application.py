import mysql.connector

def display_data(cur):
    result = cur.fetchall()
    print(result)

def guest_view(cur):
    print('')
    print("____WELCOME___")
    while True:
        print('What would you like to view?')
        print('1-Art Objects')
        print('2-Artists')
        print('3-Exhibitions')
        print('4-Quit')
        user_user_selection = input('Please enter your choice: ')
        print('')
        while user_user_selection not in ['1', '2', '3', '4']:
            user_user_selection = input('\nInvalid input.\nPlease enter a valid choice: ')
        if user_user_selection == '4':
            print('Thank you for using our database!')
            break
        elif user_user_selection == '1':
            choice = input('Would you like to see:\n1-PAINTING \n2-Sculptures Statues\n3-Other\nPlease enter your choice: ')

            if choice == '1':
                cur.execute('''SELECT
                            A.ARTIST,       A.YEAR,     A.TITLE,        A.DESCRIPTION,
                            A.CULTURE,      A.EPOCH,    A.EXHIBITION,
                            P.PAINT_TYPE,   P.Drawn_on,    P.STYLE
                            FROM ART_MUSEUM.ART_OBJECT AS A JOIN ART_MUSEUM.PAINTING AS P ON A.ID_NUM = P.ID_NUM''')
                display_data(cur)

            elif choice == '2':
                cur.execute('''SELECT
                            A.ARTIST,       A.YEAR,     A.TITLE,        A.DESCRIPTION,
                            A.CULTURE,      A.EPOCH,    A.EXHIBITION,
                            P.MATERIAL,     P.HEIGHT,   P.HEIGHT,       P.STYLE
                             FROM ART_MUSEUM.ART_OBJECT AS A JOIN ART_MUSEUM.SCULPTURE_STATUE AS P ON A.ID_NUM = P.ID_NUM''')
                display_data(cur)
                
            elif choice == '3':
                cur.execute('''SELECT
                            A.ARTIST,       A.YEAR,     A.TITLE,        A.DESCRIPTION,
                            A.CULTURE,      A.EPOCH,    A.EXHIBITION,
                            P.Type,         P.STYLE
                            FROM ART_MUSEUM.ART_OBJECT AS A JOIN ART_MUSEUM.OTHER AS P ON A.ID_NUM = P.ID_NUM''')
                display_data(cur)
            
            else:
                print('invalid input')
                continue

        elif user_user_selection == '2':
            cur.execute('''SELECT
                        NAME,               DATE_BORN,  DATE_DIED,
                        COUNTRY_OF_ORIGIN,  Epoch,      MAIN_STYLE,     DESCRIPTION
                        FROM ART_MUSEUM.ARTIST''')
            display_data(cur)

        elif user_user_selection == '3':
            cur.execute('''SELECT
                        NAME,           START_DATE,      END_DATE
                        FROM ART_MUSEUM.EXHIBITION''')
            display_data(cur)
           
        else:
            print('Invalid input.')
            continue

def get_table_names(cur):
    cur.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'ART_MUSEUM'")
    return [table[0] for table in cur.fetchall()]

def display_table(cur, table_name):
    try:
        cur.execute(f'SELECT * FROM {table_name}')
        print(f'Table {table_name}:\n')
        display_data(cur)
    except mysql.connector.Error as err:
        print(f"Something went wrong: {err}")

def add_data(cur, table_name):
    try:
        cur.execute(f'SELECT * FROM {table_name}')
        display_table(cur, table_name)

        values = []
        for desc in cur.description:
            print(f'Please enter data to add to column {desc[0]}:')
            note = 'Note: Attribute may not be NULL' if desc[6] == 0 else 'Note: If left empty, attribute will default to NULL'
            print(note)
            values.append(input())

        unpacked_values = ", ".join(["'" + value + "'" for value in values])
        cur.execute(f'INSERT INTO {table_name} VALUES ({unpacked_values})')

        display_table(cur, table_name)
    except mysql.connector.Error as err:
        print(err)

def modify_data(cur, table_name):
    try:
        cur.execute(f'SELECT * FROM {table_name}')
        display_table(cur, table_name)

        attributes = [desc[0] for desc in cur.description]
        print(f'The attributes in {table_name} are: {", ".join(attributes)}')
        
        attrib = input('\nWhich attribute would you like to modify (case-sensitive):\n')
        while attrib not in attributes:
            attrib = input('\nInvalid entry. Attribute does not exist.\nWhich attribute would you like to modify: ')
        
        cur.execute(f'SELECT {attrib} FROM {table_name}')
        
        condition_attrib = input(f'Please select a conditional attribute from the {table_name} table: ')
        while condition_attrib not in attributes:
            condition_attrib = input(f'\nInvalid entry. Conditional attribute does not exist.\nPlease select a conditional attribute from the {table_name} table: ')

        condition = input(f'Please select a value from the {condition_attrib} column associated with the modification of {attrib}\n(Note: If the value chosen is not from the column, nothing will be modified):\n')
        new_value = input(f'Please enter the new value for {attrib}: ')

        cur.execute(f"UPDATE {table_name} SET {attrib} = '{new_value}' WHERE {condition_attrib} = '{condition}'")
        display_table(cur, table_name)

    except mysql.connector.Error as err:
        print(err)

def delete_data(cur, table_name):
    try:
        cur.execute(f'SELECT * FROM {table_name}')
        display_table(cur, table_name)

        attributes = [desc[0] for desc in cur.description]
        print(f'The attributes in {table_name} are: {", ".join(attributes)}')

        attrib = input('\nWhich attribute would you like to use as a condition to delete:\n')
        while attrib not in attributes:
            attrib = input('\nInvalid entry. Attribute does not exist.\nWhich attribute would you like to use as a condition to delete: ')

        condition = input(f'Which value from {attrib} would you like to use as your condition for deletion?\nDeleting rows when {attrib} = ')
        cur.execute(f"DELETE FROM {table_name} WHERE {attrib} = '{condition}'")
        display_table(cur, table_name)

    except mysql.connector.Error as err:
        print(err)

def employee_view(cur):
    while True:
        print('\nWould you like to add new data, modify existing data, delete data, display data, or quit?')
        print('1 - Add Data')
        print('2 - Modify Existing Data')
        print('3 - Delete Data')
        print('4 - Display Data')
        print('5 - Quit')

        choice = input('Please enter your decision: ')
        while choice not in ['1', '2', '3', '4', '5']:
            choice = input('Please select a valid choice: ')

        if choice == '1':
            print('\nAvailable tables to add data are:\n')
            options = get_table_names(cur)
            print(*options, sep=', ')
            Table = input('Which table would you like to add data to: ')
            while Table not in options:
                Table = input('\nInvalid entry. Table does not exist.\nWhich table would you like to add data to: ')
            add_data(cur, Table)

        elif choice == '2':
            print('Note: All inputs are case sensitive.')
            print('\nAvailable tables to modify: ')
            options = get_table_names(cur)
            print(*options, sep=', ')
            Table = input('Which table would you like to modify: ')
            while Table not in options:
                Table = input('\nInvalid entry. Table does not exist.\nWhich table would you like to modify: ')
            modify_data(cur, Table)

        elif choice == '3':
            print('\nAvailable tables are:')
            options = get_table_names(cur)
            print(*options, sep=', ')
            Table = input('\nPlease enter the name of the table you want to delete from:')
            while Table not in options:
                Table = input('\nInvalid entry. Table does not exist.\nWhich table would you like to delete from: ')
            delete_data(cur, Table)

        elif choice == '4':
            print('Available tables are:\n')
            options = get_table_names(cur)
            print(*options, sep=', ')
            Table = input('\nPlease enter the name of the table you want to view: ')
            display_table(cur, Table)

        elif choice == '5':
            print('Thank you for using our database!')
            exit()

    

def execute_single_command(cur):
    while True:
        query = input('\nPlease enter the SQL command that you want to execute: ')
        try:
            cur.execute(query)
            querysplit = query.split()
            if querysplit[0] == 'SELECT':
                display_data(cur)
        except mysql.connector.Error as e:
            print(e)
        cont = input('Would you like to execute another command?\nY for yes, anything else for no: ')
        if cont.lower() != 'y':
            break

def execute_sql_script(cur):
    while True:
        print('\nPlease enter the directory and file name of the script you want to run:')
        print('NOTE: Please enter the directory and filename WITHOUT any quotation marks.')
        filepath = input()
        try:
            with open(filepath, 'r') as file:
                sqlFile = file.read()
                sqlCommands = sqlFile.split(';')

                for command in sqlCommands:
                    try:
                        if command.strip() != '':
                            cur.execute(command)
                    except mysql.connector.Error as msg:
                        print("Command skipped: ", msg)
        except FileNotFoundError:
            print("File not found. Please enter a valid file path.")

        cont = input('Would you like to execute another file? Y for yes, anything else for no: ')
        if cont.lower() != 'y':
            break

def admin_view(cur):
    while True:
        print('\nWould you like to:\n1-Execute an SQL command\n2-Run an SQL script\n3-Quit')
        choice = input('Please enter your selection: ')
        while choice not in ['1', '2', '3']:
            choice = input('Invalid input. Please enter a valid choice: ')

        if choice == '1':
            execute_single_command(cur)
        elif choice == '2':
            execute_sql_script(cur)
        elif choice == '3':
            print('\nThank you for using our database!')
            exit()

if __name__ == "__main__":
    
    print("___WELCOME___")
    print("Select your role:")
    print("1-Admin")
    print("2-Employee")
    print("3-Guest")
    print("4-Quit")

    user_selection = input("please type 1, 2, or 3 to select your role: ")
    while user_selection not in ['1', '2', '3', '0']:
        user_selection = input("Invalid input, please enter either 1, 2, 3, or 0: ")
    
    if user_selection == '4':
        print('Thank you for using our database!')
        exit()

    if user_selection in ['1','2']:
        username = input("username: ")
        passcode = input("password: ")

    else:
        username = "guest"
        passcode = None
    
    cnx = mysql.connector.connect(
        user=username,
        password=passcode,
        autocommit=True
    )

    if cnx.is_connected():
        print("Connection Successful")
    else:
        print("Connection Unsuccessful")

    cur = cnx.cursor(buffered=True)
    cur.execute("USE ART_MUSEUM")

    if user_selection == '3':
        guest_view(cur)
    elif user_selection == '2':
        employee_view(cur)
    elif user_selection == '1':
        admin_view(cur)
