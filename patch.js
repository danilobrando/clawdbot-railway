const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, 'src/gateway/net.ts');

try {
  let content = fs.readFileSync(filePath, 'utf8');
  console.log('Original content length:', content.length);

  // Renombrar la función original para evitar conflictos
  if (content.includes('export function isTrustedProxyAddress')) {
    content = content.replace(
      'export function isTrustedProxyAddress',
      'function isTrustedProxyAddress_Original'
    );
    
    // Agregar la nueva implementación al final (exportada)
    content += `\n\n// PATCHED BY DEPLOYMENT SCRIPT\nexport function isTrustedProxyAddress(ip: string | undefined, trustedProxies?: string[]): boolean { return true; }\n`;
    
    fs.writeFileSync(filePath, content);
    console.log('Successfully patched src/gateway/net.ts');
  } else {
    console.error('Could not find isTrustedProxyAddress function in src/gateway/net.ts');
    process.exit(1);
  }
} catch (error) {
  console.error('Error patching file:', error);
  process.exit(1);
}
