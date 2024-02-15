using System.Text;
using UnityEngine;
using UnityEngine.Windows;


namespace Myrmecoman
{
    [ExecuteInEditMode]
    public class ShaderConverter : MonoBehaviour
    {
#if UNITY_EDITOR
        [Tooltip("The path to the shader. To obtain the shader path, right click on it and click \"Copy Path\"")]
        public string path;
        [Tooltip("Click here to start converting")]
        public bool convert = false;


        private void Update()
        {
            if (convert)
            {
                convert = false;
                ProcessFile();
                Debug.Log("Shader conversion done.");
            }
        }


        private void ProcessFile()
        {
            if (path == null || path == "")
            {
                Debug.Log("The provided path is empty. To obtain the shader path, right click on it and click \"Copy Path\"");
                return;
            }

            string name = "";
            for (int i = path.Length - 1; i >= 0; i--)
            {
                if (path[i] == '\\' || path[i] == '/')
                {
                    name = path.Substring(i + 1);
                    break;
                }
            }
            byte[] content = File.ReadAllBytes(path);
            string res = Encoding.UTF8.GetString(content);

            string firstLine = "";
            for (int i = 0; i < res.Length; i++)
            {
                if (res[i] == '\n' || res[i] == '\r')
                    break;
                firstLine += res[i];
            }
            res = res.Replace(firstLine, "Shader \"VegetationInstancer/" + name.Substring(0, name.Length - 7) + "_GPU\"");
            res = res.Replace("#pragma instancing_options renderinglayer", "");
            res = res.Replace("#pragma multi_compile_instancing", "");
            res = res.Replace("ENDHLSL", "#include \"Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc\"\n#pragma instancing_options procedural:setupGPUInstancedIndirect\n#pragma multi_compile_instancing\nENDHLSL");

            byte[] newByteArray = Encoding.ASCII.GetBytes(res);
            File.WriteAllBytes("Assets/VegetationInstancer/Shaders/" + name, newByteArray);
        }
#endif
    }
}
