<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class alumnoM extends CI_Model {

	public function get_alumno(){ //Creamos una función para pedir la información de los estudiantes desde la base de datos, a continuacion procedemos con la query para la consulta de los mismos.
		/*$this->db->select('a.id_alumno, a.nombres, a.apellidos, s.nombre_sexo, c.nombre_curso'); //Seleccionamos los campos que deseamos consultar.
		$this->db->from('alumno a'); //Establecemos la tabla1
		$this->db->join('sexo s', 's.id_sexo = a.id_sexo'); //Establecemos la tabla2 y la condicion.
		$this->db->join('curso c', 'c.id_curso = a.id_curso'); //Establecemos la tabla3 y la condicion.
		$exe = $this->db->get(); //Creamos una variable exe para almacenar el resultado.
		return $exe->result();*/ //Con un return devolvemos los resultados.
		$pa_consultaralumno = "CALL pa_consultaralumno2()"; //Creamos una variable que guardará la "consulta" o la llamada al procedimiento almacenado.
		$query = $this->db->query($pa_consultaralumno); //Creamos la variable query para almacenar el resultado referenciando la base de datos con la propiedad query con los datos del procedimiento almacenado.
		if ($query->num_rows()>0) { //Hacemos un if para verificar si tenemos un resultado en la base de datos.
			return $query->result(); //Si en la condición encuentra informacion, entonces con un return y la propiedad result() nos devuelve la respuesta de la consulta.
		}else{
			return FALSE; 
		}
	}

	public function eliminar($id){
		/*$this->db->where('id_alumno', $id);
		$this->db->delete('alumno');
		if($this->db->affected_rows() > 0){
			return true;
		}else{
			return false;
		}*/
		$pa_eliminaralumno = "CALL pa_eliminaralumno(?)"; //Creamos una variable que guardará la llamada al procedimiento almacenado. Este al ser de eliminación, será necesario enviar los parametros para eliminar la informacion en la Base de datos. En este caso enviaremos 1 parametro que será el id_alumno.
        $arreglo = array('id_alumno' => $id); //Creamos un arreglo en el que guardaremos toda la informacion que recibimos a traves del formulario por el motodo POST.
        $query = $this->db->query($pa_eliminaralumno, $arreglo); //Creamos la variable query para almacenar el resultado referenciando la base de datos con la propiedad query con los datos del procedimiento almacenado.
        if ($query) { //Hacemos un if para verificar si tenemos un resultado en la base de datos. 
            return true;
        }else{
        	return false;
        }

	}

	public function get_sexo(){
		$exe = $this->db->get('sexo');
		return $exe->result();
	}

	public function get_curso(){
		$exe = $this->db->get('curso');
		return $exe->result();
	}

	public function set_alumno($datos){ //Creamos una función en el que seteamos la información de los estudiantes que seran ingresados a la base de datos, a continuacion procedemos con la query para la insercion de los mismos.
		/*$this->db->set('nombres', $datos["nombre"]); //Referenciamos a la base de datos el campo y el dato recibidos desde la funcion en el success del ajax.
		$this->db->set('apellidos', $datos["apellido"]); //Referenciamos a la base de datos el campo y el dato recibidos desde la funcion en el success del ajax.
		$this->db->set('id_sexo', $datos["sexo"]); //Referenciamos a la base de datos el campo y el dato recibidos desde la funcion en el success del ajax.
		$this->db->set('id_curso', $datos["curso"]); //Referenciamos a la base de datos el campo y el dato recibidos desde la funcion en el success del ajax.

		$this->db->insert('alumno'); //Referenciamos la propiedad de inserción en la tabla alumno de la base de datos.

		if($this->db->affected_rows()>0){ //Verifica si la condición se cumple al registrar 1 dato y devuelve la respuesta "ADD".
			return "add";
		}*/
		$pa_insertaralumno = "CALL pa_insertaralumno(?,?,?,?)"; //Creamos una variable que guardará la "consulta" o la llamada al procedimiento almacenado. Al ser un PA de almacenamiento de informacion, será necesario enviar los parametros para guardar en la Base de datos. En este caso enviaremos 4 parametros ya que el id_alumno es autoincremental. 
		$arreglo = array('nombres' => $datos["nombre"], //Creamos un arreglo en el que guardaremos toda la informacion que recibimos a traves del formulario por el motodo POST.
					 'apellidos' => $datos["apellido"], // Se le está asignando al campo de la BD el valor que viene desde el POST.
					 'id_sexo' => $datos["sexo"], // Se le está asignando al campo de la BD el valor que viene desde el POST.
					 'id_curso' => $datos["curso"]); // Se le está asignando al campo de la BD el valor que viene desde el POST.
		$query = $this->db->query($pa_insertaralumno,$arreglo); //Creamos la variable query para almacenar el resultado referenciando la base de datos con la propiedad query con los datos del procedimiento almacenado.
		if ($query!== null) { //Verifica si la condición se cumple que al recibir la información sea diferente de null.
			return "add"; //Devuelve la respuesta "ADD"
		}
			return FALSE;


	}

	public function get_datos($id){
		$this->db->where('id_alumno',$id);
		$exe = $this->db->get('alumno');

		if($exe->num_rows()>0){
			return $exe->row();
		}else{
			return false;
		}
	}


	public function actualizar($datos){
		/*$this->db->set('nombres',$datos['nombre']);
		$this->db->set('apellidos',$datos['apellido']);
		$this->db->set('id_sexo',$datos['sexo']);
		$this->db->set('id_curso',$datos['curso']);
		$this->db->where('id_alumno',$datos['id_alumno']);
		$this->db->update('alumno');

		if($this->db->affected_rows()>0){
			return "edi";
		}*/
		$pa_actualizaralumno = "CALL pa_actualizaralumno(?,?,?,?,?)"; //Creamos una variable que guardará la "consulta" o la llamada al procedimiento almacenado. Al ser un PA de actualizacion de informacion, será necesario enviar los parametros para modificarlos en la Base de datos. En este caso enviaremos 5 parametros.
        $arreglo = array('id_alumno' => $datos['id_alumno'], //Creamos un arreglo en el que guardaremos toda la informacion que recibimos a traves del formulario por el motodo POST.
        			  'nombres' => $datos['nombre'], // Se le está asignando al campo de la BD el valor que viene desde el POST.
        			  'apellidos' => $datos['apellido'], // Se le está asignando al campo de la BD el valor que viene desde el POST. 
        			  'id_sexo' => $datos['sexo'], // Se le está asignando al campo de la BD el valor que viene desde el POST.
        			  'id_curso' => $datos['curso']); // Se le está asignando al campo de la BD el valor que viene desde el POST.
        $query = $this->db->query($pa_actualizaralumno, $arreglo); //Creamos la variable query para almacenar el resultado referenciando la base de datos con la propiedad query con los datos del procedimiento almacenado.
        if ($query) {
            return "edi"; //Devuelve la respuesta "EDI"
        }
        	return FALSE;
    }
}