  $ ../printc/printc_bin.exe volatile.c
  
  typedef int  const t1;
  
  typedef int  volatile t2;
  
  typedef int  const t3;
  
  typedef int  volatile t4;
  
  typedef t  const t5;
  
  typedef t  volatile t6;
  
  typedef t  const t7;
  
  typedef t  volatile t8;
  
  typedef struct t  const t9;
  
  typedef struct t  volatile t10;
  
  typedef struct t  const t11;
  
  typedef struct t  volatile t12;
  






  $ ../printc/printc_bin.exe calipso/for.c
  
  void main()
  {
  	if(x)
  		goto l;
  	for(i = 0; i < 10; i++)
  	{
  		x--;
  		l:
  			f();
  		g();
  	}
  }
  




  $ ../printc/printc_bin.exe calipso/from.c
  
  void main()
  {
  	if(x)
  		goto lab1;
  	else
  		y();
  	lab1:
  		;
  	while(x)
  		goto lab2;
  	lab2:
  		;
  	for(i = 0; i < 5; i++)
  		goto lab3;
  	lab3:
  		;
  	{
  		int a;
  		goto lab4;
  		x++;
  		y++;
  	}
  	lab4:
  		;
  }
  


  $ ../printc/printc_bin.exe calipso/okp.c
  
  typedef int j_decompress_ptr, boolean, my_main_ptr, j_decompress_ptr, size_t,
  	JSAMPARRAY, JDIMENSION, j_common_ptr;
  
  static void process_data_context_main(j_decompress_ptr cinfo, JSAMPARRAY
  	output_buf, JDIMENSION *out_row_ctr, JDIMENSION out_rows_avail)
  {
  	my_main_ptr main = (my_main_ptr)cinfo->main;
  	if(!main->buffer_full)
  	{
  		if(!(*(cinfo->coef)->decompress_data)(cinfo,
  			(main->xbuffer)[main->whichptr]))
  			return;
  		main->buffer_full = 1;
  		main->iMCU_row_ctr++;
  	}
  	{
  		int __tag__ = main->context_state;
  		if(__tag__ == 2)
  		{
  			(*(cinfo->post)->post_process_data)(cinfo,
  				(main->xbuffer)[main->whichptr],
  				&main->rowgroup_ctr, main->rowgroups_avail,
  				output_buf, out_row_ctr, out_rows_avail);
  			if(main->rowgroup_ctr < main->rowgroups_avail)
  				return;
  			main->context_state = 0;
  			if(*out_row_ctr >= out_rows_avail)
  				return;
  			goto __tmp_0__;
  		}
  		else
  		{
  			if(__tag__ == 0)
  			{
  			case 0:
  					__tmp_0__:
  						main->rowgroup_ctr = 0;
  				main->rowgroups_avail =
  					(JDIMENSION)(cinfo->min_DCT_scaled_size
  					- 1);
  				if(main->iMCU_row_ctr == cinfo->total_iMCU_rows)
  					set_bottom_pointers(cinfo);
  				main->context_state = 1;
  				goto __tmp_1__;
  			}
  			else
  			{
  				if(__tag__ == 1)
  				{
  				case 1:
  						__tmp_1__:
  							(*(cinfo->post)->post_process_data
  								)(cinfo,
  								(main->xbuffer)[
  								main->whichptr],
  								&main->rowgroup_ctr
  								,
  								main->rowgroups_avail,
  								output_buf,
  								out_row_ctr,
  								out_rows_avail);
  					if(main->rowgroup_ctr <
  						main->rowgroups_avail)
  						return;
  					if(main->iMCU_row_ctr == 1)
  						set_wraparound_pointers(cinfo);
  					main->whichptr ^= 1;
  					main->buffer_full = 0;
  					main->rowgroup_ctr =
  						(JDIMENSION)(cinfo->min_DCT_scaled_size
  						+ 1);
  					main->rowgroups_avail =
  						(JDIMENSION)(cinfo->min_DCT_scaled_size
  						+ 2);
  					main->context_state = 2;
  					goto __tmp_2__;
  				}
  			}
  		}
  	}
  }
  
