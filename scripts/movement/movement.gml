//lembrar de cirar as variáveis no create do personagem
/*
	velh = 0;
	velv = 0;
	vel = 4;
	grav = 0.3;
	vel_jump = 7;

	inputs = {
		left : ord("A"),
		right : ord("D"),
		jump : vk_space
	}
*/
function cira_var_create() {
	velh = 0;
	velv = 0;
	vel = 6;
	grav = 0.3;
	vel_jump = 10;

	inputs = {
		left : ord("A"),
		right : ord("D"),
		jump : vk_space
	}
}

function move_step() {
	//controle player
	var _chao = place_meeting(x, y +1, obj_ground);

	var _left, _right, _jump;
	_left = keyboard_check(inputs.left);
	_right = keyboard_check(inputs.right);
	_jump = keyboard_check_pressed(inputs.jump);

	velh = (_right - _left) * vel;

	//pulando
	if (_chao) {
	
		if (_jump) {
			velv =- vel_jump;
		} 
	
		//se eu estou no chão e me movendo 
		if (velh != 0) {
			//mudo a sprite
			sprite_index = spr_player_run;
			//fazer ele olhar para onde estou indo
			image_xscale = sign(velh);
		} else {
			sprite_index = spr_player_idol;
		}
	} else { // não estou no chao

		if (velh != 0) {
			image_xscale = sign(velh);
		}
	
		//mudando as sprites quando o player pula e cai
		if (velv < 0) {
			sprite_index = spr_player_jump;
		} else {
			sprite_index = spr_player_fall;
		}
	
		//gravidade
		velv += grav;
	}
}

function move_endstep() {
	//colisao horizontal
	//checande se estou colidindo com a parede
	var _col = instance_place(x + velh, y, obj_ground);
	// se colidir grudo em quem colidi
	if (_col) {
		//checando direita
		if (velh > 0) {
			//grudando na parede esquerda
			x = _col.bbox_left + (x - bbox_right);
		}
	
		//checando esquerda
		if (velh < 0) {
			x = _col.bbox_right + (x - bbox_left);
		}
	
		//uma vez que eu colidi, não importa o lado, eu paro
		velh = 0;
	}

	x += velh;

	//colisão vertical

	var _col = instance_place(x, y + velv, obj_ground);

	if (_col) {
		if (velv > 0) {
			//colisao para baixo
			y = _col.bbox_top + (y - bbox_bottom);
		}
	
	
		if (velv < 0) {
			//colisao para cima
				y = _col.bbox_bottom + (y - bbox_top);
		}
	
		velv = 0;
	}	

	y += velv;
}