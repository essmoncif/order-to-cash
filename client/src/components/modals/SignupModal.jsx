import React, { useEffect, useState } from "react";
import Modal from "@material-ui/core/Modal";
import { makeStyles } from "@material-ui/core/styles";
import Radio from '@mui/material/Radio';
import RadioGroup from '@mui/material/RadioGroup';
import FormControlLabel from '@mui/material/FormControlLabel';
import Button from '@mui/material/Button';

const useStyles = makeStyles(theme => ({
  modal: {
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    justifyContent: "center"
    //maxWidth: "500px"
  },
  paper: {
    backgroundColor: theme.palette.background.paper,
    border: "2px solid #000",
    boxShadow: theme.shadows[5],
    padding: theme.spacing(2, 4, 3)
  },
  form: {
    fontfamily: "Georgia",
    padding: "20px",
    width: "100%",
    maxWidth: "500px",
    background: "#f4f7f8"
  },
  area: {
    width: "100%",
    background: "rgba(255,255,255,.1)",
    border: "none",
    borderRadius: "4px",
    fontSize: "15px",
    outline: "0",
    padding: "10px",
    margin: "1em auto",
    boxSizing: "border-box",
    backgroundColor: "#e8eeef",
    color: "#8a97a0"
  },
  submit: {
  
    marginLeft: "auto",
    marginRight: "auto"
  }
}));

function SignupModal({address, open, handleClose, proxyInstance}) {
  const [username, setUsername] = useState('')
  const [userType, setUserType] = useState('')
  const [ready, setready] = useState(false)
  const classes = useStyles();

  useEffect(() => {
    if(username !== '' && userType !== ''){
      setready(true)
    }else{
      setready(false)
    }
  },[username, userType])

  async function submit(){
    if(ready){
      var addressOfContract
      if(userType === 'Client'){
        addressOfContract = await proxyInstance.methods.createClient(username, address).call()
      }else{
        addressOfContract = await proxyInstance.methods.createSupplier(username, address).call()
      }
    }
    console.log(addressOfContract)
  }
  
  return (
    <div>
      <Modal open={open} onClose={handleClose} className={classes.modal} >
        <div className={classes.form}>
          <input className={classes.area} value={address} disabled/>
          <input className={classes.area} placeholder="Username" value={username} onChange={(event) => setUsername(event.target.value)} />
          <RadioGroup
            aria-label="gender"
            name="controlled-radio-buttons-group"
            value={userType}
            onChange={(event) => setUserType(event.target.value)}
          >
            <FormControlLabel value="Client" control={<Radio />} label="Client" />
            <FormControlLabel value="Supplier" control={<Radio />} label="Supplier" />
          </RadioGroup>
          <Button variant="contained" disabled={!ready} className={classes.submit} onClick={submit} >Sign up</Button>
          
        </div>
      </Modal>
    </div>
  );
}
export default SignupModal;
