import React, { useEffect, useState } from 'react'
import getWeb3 from '../provider/web3'

export default function Accueil() {
    const [web3, setWeb3] = useState<any| null>(null)
    const [account, setAccount] = useState<string>('')
    const [contract, setContract] = useState<any| null>(null)

    useEffect(() => {
        async function fetchWeb3(){
            const wb3 = await getWeb3()
            
        }
    })

    return (
        <div>
            
        </div>
    )
}
