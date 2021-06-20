#include <stdio.h>
#include <string.h>
#include "platform.h"
#include "xgpio.h"
#include "xparameters.h"
#include "xil_printf.h"



int main()
{
	char my_string[10] = {};
	u_int8_t mux_sel_data = 0;

    init_platform();

    // AXI GPIO instance
    XGpio mux_select;
    XGpio_Initialize(&mux_select,XPAR_AXI_GPIO_0_DEVICE_ID);

    // set as output (to rtl code)
    XGpio_SetDataDirection(&mux_select,1,0);

    print("Here are the following Emojis that can be animated:\n\r");
    print("happy\n");
    print("sad\n");
    print("mad\n");
    print("crazy\n");
    print("Please type in of these emotions:\n");

    for(int i = 0; i < 5; i++){
		scanf("%s", my_string);
		print("\n");
		printf("you entered: %s\n", my_string);

		if(strcmp(my_string, "happy") == 0){
			mux_sel_data = 0;
		}
		else if(strcmp(my_string, "sad") == 0){
			mux_sel_data = 1;
		}
		else if(strcmp(my_string, "mad") == 0){
			mux_sel_data = 2;
		}
		else if(strcmp(my_string, "crazy") == 0){
			mux_sel_data = 3;
		}

		XGpio_DiscreteWrite(&mux_select,1,mux_sel_data);

		print("\n");
		print("Please type another emotion:\n");
    }

    print("Thank you for animating my Emojis!");

    cleanup_platform();
    return 0;
}
