import React, {useState, useEffect} from 'react'
import getWeb3 from '../provider/Web3'
import Proxy from '../ABI/Proxy.json'
import Head from '../components/header/Head'
import SignupModal from '../components/modals/SignupModal'

export default function Accueil() {
    const [web3, setWeb3] = useState(null)
    const [proxyContract, setProxyContract] = useState(null)
    const [address, setAddress] = useState(null)
    const [openModal, setOpenModal] = useState(false)

    useEffect(() => {
        async function fetchWeb3(){
            const wb3 = await getWeb3()
            const accounts = await wb3.eth.getAccounts()
            const networkId = await wb3.eth.net.getId()
            const deployedNetwork = Proxy.networks[networkId]
            const proxyInstance = new wb3.eth.Contract(Proxy.abi, deployedNetwork && deployedNetwork.address)
            setProxyContract(proxyInstance)
            setWeb3(wb3)
            setAddress(accounts[0])
        }
        fetchWeb3()
    }, [])

    useEffect(() => {
        async function checkUser() {
            if(address && proxyContract) {
                const suppliersAddress = await proxyContract.methods.getSuppliersAddress().call()
                const clientsAddress = await proxyContract.methods.getClientsAddress().call()
                if(!suppliersAddress.includes(address) && !clientsAddress.includes(address)){
                    setOpenModal(true)
                }
                console.log(suppliersAddress, clientsAddress)
            }
        }
        checkUser()
    }, [address, proxyContract])

    function handleClose() {
        setOpenModal(false)
    }

    return (
        <>
            <Head/>
            {address && proxyContract && <SignupModal address={address} open={openModal} handleClose={handleClose} proxyInstance={proxyContract} />}
        </>
    )
}
