/* stats */
extern unsigned char level;
extern unsigned char hp,max_hp;
extern unsigned char mp,max_mp;
extern unsigned char limit;
extern unsigned char money,experience;
extern unsigned char time_hours,time_minutes;
extern unsigned char items1,items2;
extern unsigned char steps;


struct fixed_type {
        char i;
        unsigned char f;
};

int opening(void);
int title(void);
int flying(void);

void game_over(void);
void show_map(void);
void print_info(void);
void print_help(void);

int name_screen(void);

int do_battle(int background);

int do_ending(void);

int world_map(void);

int city_map(void);

int credits(void);
