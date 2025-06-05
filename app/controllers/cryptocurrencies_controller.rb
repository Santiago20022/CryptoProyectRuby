class CryptocurrenciesController < ApplicationController
  def index
    url = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,binancecoin,cardano,solana,xrp,polkadot,dogecoin,avalanche-2,shiba-inu,polygon,chainlink,litecoin,bitcoin-cash,uniswap,algorand,stellar,vechain,filecoin,tron,cosmos,ethereum-classic,monero,hedera-hashgraph,internet-computer,fantom,near,flow,decentraland,the-sandbox,axie-infinity,pancakeswap-token,theta-token,elrond-erd-2,klay-token,helium,zcash,dash,compound,maker,yearn-finance,sushiswap,1inch,curve-dao-token,aave,synthetix-network-token,uma,balancer,kyber-network-crystal,0x,ren,bancor,loopring,storj,basic-attention-token,enjincoin,chiliz,fet,ocean-protocol,numeraire,the-graph,livepeer,audius,ankr,request-network,civic,district0x,status,power-ledger,metal,waltonchain,wax,holo,iostoken,zilliqa,ontology,qtum,icon,lisk,nano,waves,komodo,ark,stratis,neblio,particl,nuls,pivx,syscoin,vertcoin,digibyte,ravencoin,horizen,beam,grin,handshake,nervos-network,harmony,tomochain,wan,iotex,thunder-token,celer-network,orion-protocol,injective-protocol,origin-protocol,nucypher,keep-network,skale,cartesi&vs_currencies=usd"
    
    begin
      response = HTTParty.get(url)

      # Verifica si la respuesta es exitosa
      if response.success?
        @crypto_data = response.parsed_response
        
        Rails.logger.info "Datos de criptomonedas obtenidos con éxito: #{@crypto_data.inspect}"  # Agrega este log
      else
        @error_message = "Error al obtener los datos de la API. Código de respuesta: #{response.code}"
      end
    rescue StandardError => e
      @error_message = "Error al obtener los datos: #{e.message}"
    end
  end

  def create
    json_data = params[:crypto_data]
    if json_data.blank?
      error_message = "No se recibieron datos de criptomonedas."
      return render :index
    end

    crypto_data = JSON.parse(json_data)
    crypto_key = crypto_data.keys.sample
    selected_data = crypto_data[crypto_key]
    @crypto_data = crypto_data
    @selected_crypto = RandomSelection.create!(name: crypto_key, price: selected_data["usd"])

    redirect_to cryptocurrency_path(@selected_crypto)
    
  end

  def show
    @selected_crypto = RandomSelection.last
  end

  def update
    @selected_crypto = RandomSelection.find(params[:id])
    if @selected_crypto.update(price: params[:random_selection][:price])
      redirect_to cryptocurrency_path(@selected_crypto), notice: "Precio actualizado correctamente."
    else
      flash.now[:alert] = "Error al actualizar el precio."
      render :show
    end
  end

end